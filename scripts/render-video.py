import argparse
from pathlib import Path
import subprocess
import sys
import time


def parse_args():
    parser = argparse.ArgumentParser(
        description="Render video-1min.html to MP4 using Playwright + ffmpeg."
    )
    parser.add_argument("--html", default="video-1min.html", help="Path to HTML file.")
    parser.add_argument("--duration", type=float, default=60, help="Capture duration in seconds.")
    parser.add_argument("--width", type=int, default=1920, help="Viewport width.")
    parser.add_argument("--height", type=int, default=1080, help="Viewport height.")
    parser.add_argument("--fps", type=int, default=30, help="Output FPS for MP4.")
    parser.add_argument("--crf", type=int, default=18, help="H.264 CRF quality (lower = better, larger file).")
    parser.add_argument("--out", default="renders", help="Output directory for WebM/MP4.")
    parser.add_argument("--mp4", default="video-1min.mp4", help="MP4 output filename.")
    return parser.parse_args()


def main():
    args = parse_args()
    html_path = Path(args.html).resolve()
    if not html_path.exists():
        print(f"HTML not found: {html_path}", file=sys.stderr)
        return 1

    out_dir = Path(args.out).resolve()
    out_dir.mkdir(parents=True, exist_ok=True)
    mp4_path = out_dir / args.mp4
    webm_path = out_dir / (Path(args.mp4).stem + ".webm")
    url = html_path.as_uri() + "?once=1"
    try:
        from playwright.sync_api import sync_playwright
    except ImportError:
        print("Playwright not installed. Run: pip install playwright", file=sys.stderr)
        return 1

    print(f"HTML: {html_path}")
    print(f"Recording: {args.duration}s at {args.width}x{args.height}")
    print(f"Target MP4: {mp4_path}")
    print(f"Encoding: H.264 CRF {args.crf}, {args.fps} fps")
    with sync_playwright() as p:
        browser = p.chromium.launch(
            headless=True,
            args=[
                "--autoplay-policy=no-user-gesture-required",
                "--disable-background-timer-throttling",
                "--disable-renderer-backgrounding",
                "--disable-backgrounding-occluded-windows",
            ],
        )
        context = browser.new_context(
            viewport={"width": args.width, "height": args.height},
            record_video_dir=str(out_dir),
            record_video_size={"width": args.width, "height": args.height},
        )
        page = context.new_page()
        page.goto(url, wait_until="load")
        page.evaluate("document.fonts.ready")
        page.wait_for_timeout(500)
        page.wait_for_timeout(int(args.duration * 1000))
        video = page.video
        context.close()
        video.save_as(str(webm_path))
        video.delete()
        browser.close()

    for _ in range(40):
        if webm_path.exists() and webm_path.stat().st_size > 0:
            break
        time.sleep(0.25)

    if not webm_path.exists() or webm_path.stat().st_size == 0:
        print(f"WebM not saved or empty: {webm_path}", file=sys.stderr)
        return 1

    try:
        subprocess.run(
            [
                "ffmpeg",
                "-y",
                "-i",
                str(webm_path),
                "-c:v",
                "libx264",
                "-pix_fmt",
                "yuv420p",
                "-r",
                str(args.fps),
                "-crf",
                str(args.crf),
                "-preset",
                "medium",
                str(mp4_path),
            ],
            check=True,
        )
    except FileNotFoundError:
        print("ffmpeg not found. Install ffmpeg and ensure it is in PATH.", file=sys.stderr)
        return 1

    print(f"WebM saved: {webm_path}")
    print(f"MP4 saved: {mp4_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
