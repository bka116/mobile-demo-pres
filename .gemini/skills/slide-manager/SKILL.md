---
name: Slide Manager
description: Управление слайдами презентации mobileDemo - создание, редактирование и сборка
---

# Slide Manager — Управление слайдами презентации

Этот скилл помогает управлять слайдами презентации мобильного приложения ПУСК.

## Структура проекта

```
mobileDemo/
├── src/
│   ├── template.html          # Основной шаблон с {{slides}}
│   └── slides/
│       ├── slide-01.html      # Отдельные слайды
│       ├── slide-02.html
│       └── ...
├── demo4.html                 # Собранная презентация
├── demo4.pdf                  # PDF версия
├── screen_*.png               # Скриншоты приложения
└── scripts/
    ├── build-demo4.py         # Скрипт сборки HTML
    └── export-pdf.ps1         # Скрипт экспорта в PDF
```

## Доступные скриншоты

При создании слайдов используй существующие скриншоты:
- `screen_auth.png` — Авторизация
- `screen_main.png` — Главный экран
- `screen_camera.png` — Камера
- `screen_check_detail.png` — Детали проверки
- `screen_checks_list.png` — Список проверок
- `screen_documents.png` — Документы
- `screen_editor.png` — Редактор
- `screen_field_work.png` — Полевая работа
- `screen_gallery.png` — Галерея
- `screen_notifications.png` — Уведомления
- `screen_objects.png` / `screen_objects_list.png` — Объекты
- `screen_photos.png` — Фото
- `screen_plan.png` — План
- `screen_violation.png` — Нарушение
- `screen_violations_list.png` — Список нарушений

## Шаблон нового слайда

При создании нового слайда используй этот шаблон:

```html
<!-- СЛАЙД N: Название слайда -->
<div class="slide active" data-step="N">
    <div class="max-w-5xl mx-auto w-full">
        <!-- Заголовок секции -->
        <div class="text-center mb-12 fade-in-up">
            <span class="inline-block px-4 py-1 rounded-full bg-blue-50 text-blue-600 text-sm font-semibold mb-4 border border-blue-100">
                Название раздела
            </span>
            <h2>Заголовок слайда</h2>
            <p class="text-xl text-gray-500 mt-4 max-w-2xl mx-auto">
                Описание слайда
            </p>
        </div>
        
        <!-- Контент слайда -->
        <div class="grid grid-cols-2 gap-8">
            <!-- Левая колонка -->
            <div class="fade-in-up delay-100">
                <!-- Контент -->
            </div>
            
            <!-- Правая колонка с телефоном -->
            <div class="fade-in-up delay-200 flex justify-center">
                <div class="phone-mockup" style="height: 540px; border-width: 6px;">
                    <div class="phone-notch"></div>
                    <img src="screen_main.png" alt="Описание скриншота"
                        onerror="this.src='https://placehold.co/375x812?text=Скриншот'">
                </div>
            </div>
        </div>
    </div>
</div>
```

## Стили и компоненты

### Карточка с иконкой
```html
<div class="card-step p-6 flex items-start gap-4">
    <div class="w-12 h-12 rounded-xl bg-gradient-to-br from-blue-400 to-blue-600 flex items-center justify-center text-white shadow-lg">
        <!-- SVG иконка -->
    </div>
    <div>
        <h3 class="font-bold text-gray-800 mb-1">Заголовок</h3>
        <p class="text-gray-500 text-sm">Описание</p>
    </div>
</div>
```

### Телефон с mockup
```html
<div class="phone-mockup" style="height: 540px; border-width: 6px;">
    <div class="phone-notch"></div>
    <img src="screen_name.png" alt="Описание">
</div>
```

### Анимации появления
- `fade-in-up` — появление снизу
- `delay-100`, `delay-200`, `delay-300` — задержка анимации

### Цветовые градиенты
- Синий: `from-blue-400 to-blue-600`
- Зелёный: `from-green-400 to-emerald-500`
- Фиолетовый: `from-purple-400 to-purple-600`
- Оранжевый: `from-orange-400 to-orange-600`

## Команды сборки

### Собрать HTML презентацию
```powershell
python scripts/build-demo4.py
```

### Экспорт в PDF
```powershell
powershell -ExecutionPolicy Bypass -File scripts/export-pdf.ps1
```

## Правила работы со слайдами

1. **Нумерация**: Слайды нумеруются последовательно: `slide-01.html`, `slide-02.html`, и т.д.
2. **data-step**: Атрибут `data-step` должен соответствовать номеру слайда
3. **Комментарий**: Каждый слайд начинается с комментария `<!-- СЛАЙД N: Название -->`
4. **Адаптивность**: Используй `grid-cols-1 md:grid-cols-2` для адаптивной вёрстки
5. **Hover-эффекты**: Добавляй `hover:shadow-xl hover:border-blue-300 transition-all` к интерактивным элементам

## Частые задачи

### Добавить новый слайд
1. Создай файл `src/slides/slide-XX.html` с нужным номером
2. Используй шаблон выше
3. Запусти `python scripts/build-demo4.py`

### Изменить порядок слайдов
1. Переименуй файлы с новыми номерами
2. Обнови `data-step` внутри каждого слайда
3. Пересобери презентацию

### Добавить новый скриншот
1. Сохрани PNG файл в корень проекта с именем `screen_название.png`
2. Используй в слайде: `<img src="screen_название.png" alt="...">`
