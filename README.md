# oscript-i18n

Библиотека для интернационализации приложения на OneScript.

## Установка

``` bash
opm install i18n
```

## Описание

- [Пакеты ресурсов](#пакеты-ресурсов)
- [Глобальные локали](#глобальные-локали)
- [Встраивание в код приложения](#встраивание-в-код-приложения)
- [Публичный интерфейс](docs/README.md)

## Пакеты ресурсов

Основой библиотеки служат пакеты ресурсов, в которых хранятся специфичные для локали объекты. 
Ресурсы представляют из себя переводы текстов, шаблоны, форматы, настройки и т.д. Они описываются в текстовом формате [.properties](https://ru.wikipedia.org/wiki/.properties) в виде пар "ключ-значение", либо через собственный класс `.os`, в котором можно уже использовать ресурсы любого типа.

### Структура каталогов

Рекомендуемая структура хранения файлов ресурсов:

```
...
src/
└── locales/
    ├── ru/
    ├── en/
    ├── es/
    └── ...
```

### Правила наименования файлов ресурсов

Именование файла ресурсов играет важную роль, т.к. по имени файла определяется его базовое имя пакета и локаль. Допустимые форматы имени файла следующие:

- `<Базовое имя пакета>.<Расширение>` - ресурсы будут доступны для всех локалей.
- `<Базовое имя пакета>_<Код языка>.<Расширение>` - ресурсы будут доступны для указанного языка и для всех стран языка.
- `<Базовое имя пакета>_<Код языка>_<Код страны>.<Расширение>` - ресурсы будут доступны только для указанного языка и страны.

### Вариант описания ресурсов через файл .properties

Файлы с расширением **.properties** являются обычными текстовыми файлами, в которой хранятся пары "ключ-значение" на каждой строке, записанные в формате: `ключ = значение` или `ключ : значение`.

<sub>./locales/ru/РесурсыКонсольногоПриложения_ru.properties</sub>
``` properties
ОписаниеПриложения = Приложение запускает \
                     и останавливает сервис

# Имена команд
Имя.Старт = Старт
Имя.Стоп = Стоп

# Описания команд
Описание.Старт = Останавливает сервис
Описание.Стоп = Запускает сервис
```

<sub>./locales/en/РесурсыКонсольногоПриложения_en.properties</sub>
``` properties
ОписаниеПриложения = Application starts and \
                     stops the service

# Имена команд
Имя.Старт = Start
Имя.Стоп = Stop

# Описания команд
Описание.Старт = Stops the service
Описание.Стоп = Starts the service
```

### Вариант описания ресурсов через класс (.os)

<sub>./locales/ru/РесурсыКонсольногоПриложения_ru.os</sub>
``` bsl
Функция ПолучитьРесурсы() Экспорт

	Ресурсы = Новый Соответствие();
	Ресурсы.Вставить("ОписаниеПриложения", "Приложение запускает и останавливает сервис");

	// Имена команд
	Ресурсы.Вставить("Имя.Старт", "Старт");
	Ресурсы.Вставить("Имя.Стоп", "Стоп");

	// Описания команд
	Ресурсы.Вставить("Описание.Старт", "Останавливает сервис");
	Ресурсы.Вставить("Описание.Стоп", "Запускает сервис");

	Возврат Ресурсы;

КонецФункции
```

<sub>./locales/en/РесурсыКонсольногоПриложения_en.os</sub>
``` bsl
Функция ПолучитьРесурсы() Экспорт

	Ресурсы = Новый Соответствие();
	Ресурсы.Вставить("ОписаниеПриложения", "Application starts and stops the service");

	// Имена команд
	Ресурсы.Вставить("Имя.Старт", "Start");
	Ресурсы.Вставить("Имя.Стоп", "Stop");

	// Описания команд
	Ресурсы.Вставить("Описание.Старт", "Stops the service");
	Ресурсы.Вставить("Описание.Стоп", "Starts the service");

	Возврат Ресурсы;

КонецФункции
```

### Механизм поиска файлов ресурсов пакета

Поиск файлов ресурсов происходит в определенном порядке. Рассмотрим на следующем примере:

Условия:
- Базовое имя пакета: `МоиРесурсы`
- Текущая локаль: `ru_RU`</br>
- Локаль по умолчанию: `en_UK`
- Имеющиеся файлы ресурсов: _МоиРесурсы_en.os_, _МоиРесурсы.properties_

Сначала загрузчик попытается найти файлы в следующем порядке:
- МоиРесурсы_ru_RU.os
- МоиРесурсы_ru_RU.properties
- МоиРесурсы_ru.os
- МоиРесурсы_ru.properties
- МоиРесурсы.os
- МоиРесурсы.properties

На этом этапе загрузчик найдет файл _МоиРесурсы.properties_, который будет пропущен, т.к. это базовый пакет. 
Далее загрузчик попытается найти следующие файлы:
 
- МоиРесурсы_en_UK.os
- МоиРесурсы_en_UK.properties
- МоиРесурсы_en.os
- МоиРесурсы_en.properties
- МоиРесурсы.os
- МоиРесурсы.properties

На этом этапе найдутся файлы _МоиРесурсы_en.os_ и _МоиРесурсы.properties_, на основании которых будет собран пакет.

## Глобальные локали

Глобальные локали необходимы для автоматического определения пакета ресурсов. Взаимодействие с ними происходит через статичный класс библиотеки [Мультиязычность](docs/Мультиязычность.md). 

### Текущая локаль

Значение по умолчанию: `ru_RU`</br>
Используется для определения пакета ресурсов.

``` bsl
// Получение
ТекущаяЛокаль = Мультиязычность.ТекущаяЛокаль();

// Установка
Мультиязычность.УстановитьЛокаль("es_ES");
```

### Локаль по умолчанию

Значение по умолчанию: `en_UK`</br>
Используется для определения пакета ресурсов, когда по текущей локали не найден пакет.

``` bsl
// Получение
ЛокальПоУмолчанию = Мультиязычность.ЛокальПоУмолчанию();

// Установка
Мультиязычность.УстановитьЛокальПоУмолчанию("es_ES");
```

## Встраивание в код приложения

### Подключение пакетов ресурсов

Чтобы подключить пакеты ресурсов, необходимо в точке инициализации вашего приложения добавить конструкцию указания местоположения файлов ресурсов:

<sub>./src/main.os</sub>
``` bsl
ПутьКРесурсам = ОбъединитьПути(ТекущийСценарий().Каталог, "locales");

МенеджерРесурсовЛокализации.ДобавитьКаталог(ПутьКРесурсам);
```

### Получение пакета

``` bsl
// Один пакет
Пакет = МенеджерРесурсовЛокализации.ПолучитьПакет("РесурсыКонсольногоПриложения");

// Либо группа пакетов
ГруппаПакетов = МенеджерРесурсовЛокализации.ПолучитьПакеты("РесурсыКонсольногоПриложения, ОбщиеРесурсы");
```

### Использование пакета по умолчанию

Если в вашем проекте используется фиксированное количество пакетов, то можно установить использование этих пакетов по умолчанию. 
Это позволит не обращаться за ресурсами напрямую к пакету, а получать их через статичный класс [Мультиязычность](docs/Мультиязычность.md). 
Также при [изменении](docs/Мультиязычность.md#установитьлокаль) локали, пакет по умолчанию будет переключаться на соответствющий язык.

``` bsl
// Использование пакета по умолчанию
Пакет = МенеджерРесурсовЛокализации.ПолучитьПакет("РесурсыКонсольногоПриложения");
Пакет.ИспользоватьПоУмолчанию();

// Использование группы пакетов по умолчанию
ГруппаПакетов = МенеджерРесурсовЛокализации.ПолучитьПакеты("РесурсыКонсольногоПриложения, ОбщиеРесурсы");
ГруппаПакетов.ИспользоватьПоУмолчанию();
```

### Получение конкретного ресурса

``` bsl
// Из пакета или группы пакетов
ОписаниеПриложения = Пакет.ПолучитьРесурс("ОписаниеПриложения");
Сообщение = Пакет.ПолучитьСтроку("Приветствие", "Подставляемый текст");

// Из пакета по умолчанию
ОписаниеПриложения = Мультиязычность.ПолучитьРесурс("ОписаниеПриложения");
Сообщение = Мультиязычность.ПолучитьСтроку("Приветствие", "Подставляемый текст");
```

### Заполнение шаблона

Чтобы использовать механизм подстановки данных в шаблон, текст необходимо разметить с помощью конструкции `{t(ИмяРесурса)}`

``` bsl
Шаблон = "{
|  'ОписаниеПриложения': '{t(ОписаниеПриложения)}',
|  'Команды': {
|    'Старт': {
|      'Имя': '{t(Имя.Старт)}',
|      'Описание': '{t(Описание.Старт)}'
|    },
|    'Стоп': {
|      'Имя': '{t(Имя.Стоп)}',
|      'Описание': '{t(Описание.Стоп)}'
|    }
|  }
|}";

Пакет.ЗаполнитьШаблон(Шаблон);

// Для пакета по умолчанию
Мультиязычность.ЗаполнитьШаблон(Шаблон); 
```

Более подробно написано в описании [публичного интерфейса](docs/README.md)
