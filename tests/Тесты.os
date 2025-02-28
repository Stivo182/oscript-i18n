#Использовать asserts
#Использовать "../src"

Процедура ПередЗапускомТестов() Экспорт
	МенеджерРесурсовЛокализации.ДобавитьКаталог("tests/locales");
КонецПроцедуры

Процедура ПередЗапускомТеста() Экспорт
	Мультиязычность.УстановитьЛокаль("ru_RU");
	Мультиязычность.УстановитьЛокальПоУмолчанию("en_UK");
КонецПроцедуры

&Тест
Процедура ТестДолжен_ПроверитьУстановкуТекущейЛокалиБезСтраны() Экспорт

	Мультиязычность.УстановитьЛокаль("ru");

	Ожидаем.Что(Мультиязычность.ТекущаяЛокаль(), "Локаль").Равно("ru");
	Ожидаем.Что(Мультиязычность.ТекущийЯзык(), "Язык").Равно("ru");
	Ожидаем.Что(Мультиязычность.ТекущаяСтрана(), "Страна").Равно("");

КонецПроцедуры

&Тест
Процедура ТестДолжен_ПроверитьУстановкуТекущейЛокалиСоСтраной() Экспорт

	Мультиязычность.УстановитьЛокаль("ru_RU");

	Ожидаем.Что(Мультиязычность.ТекущаяЛокаль(), "Локаль").Равно("ru_RU");
	Ожидаем.Что(Мультиязычность.ТекущийЯзык(), "Язык").Равно("ru");
	Ожидаем.Что(Мультиязычность.ТекущаяСтрана(), "Страна").Равно("RU");

КонецПроцедуры

&Тест
Процедура ТестДолжен_ПроверитьУстановкуЛокалиПоУмолчанию() Экспорт

	Мультиязычность.УстановитьЛокальПоУмолчанию("ru");

	Ожидаем.Что(Мультиязычность.ЛокальПоУмолчанию()).Равно("ru");

КонецПроцедуры

&Тест
Процедура ТестДолжен_ПроверитьЧтоПакетыЗагружены() Экспорт

	Мультиязычность.УстановитьЛокальПоУмолчанию("");

	Пакеты = Новый Соответствие();
	Пакеты.Вставить("РесурсыЛокализации_", МенеджерРесурсовЛокализации.ПолучитьПакет("РесурсыЛокализации", ""));
	Пакеты.Вставить("РесурсыЛокализации_ru", МенеджерРесурсовЛокализации.ПолучитьПакет("РесурсыЛокализации", "ru"));
	Пакеты.Вставить("РесурсыЛокализации_ru_RU", МенеджерРесурсовЛокализации.ПолучитьПакет("РесурсыЛокализации", "ru_RU"));
	Пакеты.Вставить("РесурсыЛокализации_en_UK", МенеджерРесурсовЛокализации.ПолучитьПакет("РесурсыЛокализации", "en_UK"));
	Пакеты.Вставить("РесурсыЛокализации_en_US", МенеджерРесурсовЛокализации.ПолучитьПакет("РесурсыЛокализации", "en_US"));
	Пакеты.Вставить("РесурсыЛокализации_de", МенеджерРесурсовЛокализации.ПолучитьПакет("РесурсыЛокализации", "de"));

	Пакеты.Вставить("РесурсыЛокализацииКоманд_en", МенеджерРесурсовЛокализации.ПолучитьПакет("РесурсыЛокализацииКоманд", "en"));
	Пакеты.Вставить("РесурсыЛокализацииКоманд_ru_RU", МенеджерРесурсовЛокализации.ПолучитьПакет("РесурсыЛокализацииКоманд", "ru_RU"));
	
	Для Каждого Строка Из Пакеты Цикл
		Локаль = Строка.Ключ;
		Пакет = Строка.Значение;
		
		Ожидаем.Что(Пакет, Локаль).Заполнено();
		Ожидаем.Что(Пакет.БазовоеИмя() + "_" + Пакет.Локаль()).Равно(Локаль);
	КонецЦикла;

КонецПроцедуры

&Тест
Процедура ТестДолжен_ПроверитьПолучениеПакетаТекущейЛокали() Экспорт

	Пакет = МенеджерРесурсовЛокализации.ПолучитьПакет("РесурсыЛокализации");
	
	Ожидаем.Что(Пакет.Локаль()).Равно("ru_RU");
	Ожидаем.Что(Пакет.Получить("ПолноеИмя")).Равно("РесурсыЛокализации_ru_RU");

КонецПроцедуры

&Тест
Процедура ТестДолжен_ПроверитьПолучениеПакетаПоЛокалиПоУмолчанию() Экспорт

	Пакет = МенеджерРесурсовЛокализации.ПолучитьПакет("РесурсыЛокализации", "es_ES");
	
	Ожидаем.Что(Пакет.Локаль()).Равно("en_UK");
	Ожидаем.Что(Пакет.Получить("ПолноеИмя")).Равно("РесурсыЛокализации_en_UK");
	
КонецПроцедуры

&Тест
Процедура ТестДолжен_ПроверитьЧтоПакетСобираетсяТолькоОдинРаз() Экспорт

	Пакет1 = МенеджерРесурсовЛокализации.ПолучитьПакет("РесурсыЛокализации", "ru");
	Пакет2 = МенеджерРесурсовЛокализации.ПолучитьПакет("РесурсыЛокализации", "ru");

	Ожидаем.Что(Пакет1).Равно(Пакет2);

КонецПроцедуры

&Тест
Процедура ТестДолжен_ПроверитьПриоритетПакетаХранящегосяВКлассеПередФайлом() Экспорт

	Пакет = МенеджерРесурсовЛокализации.ПолучитьПакет("РесурсыЛокализации");

	// Полное имя обеих источников совпадает
	Ожидаем.Что(Пакет.Получить("ПолноеИмя")).Равно("РесурсыЛокализации_ru_RU");

	// Присутствует и в классе, и в файле, но взял из класса
	Ожидаем.Что(Пакет.Получить("Приветствие")).Равно("Привет!");

	// Отсутствует в классе, но есть в файле
	Ожидаем.Что(Пакет.Получить("Прощание")).Равно("До свидания"); 

КонецПроцедуры

&Тест
Процедура ТестДолжен_ПроверитьНахождениеПакетаПоЯзыкуКогдаПоСтранеНеНайдено() Экспорт

	Пакет = МенеджерРесурсовЛокализации.ПолучитьПакет("РесурсыЛокализации", "de_DE");

	Ожидаем.Что(Пакет.Получить("ПолноеИмя")).Равно("РесурсыЛокализации_de");

КонецПроцедуры

&Тест
Процедура ТестДолжен_ПроверитьПолучениеРодительскогоРесурса() Экспорт

	Пакет = МенеджерРесурсовЛокализации.ПолучитьПакет("РесурсыЛокализации", "ru_RU");

	Ожидаем.Что(Пакет.Получить("ПолноеИмя")).Равно("РесурсыЛокализации_ru_RU");
	Ожидаем.Что(Пакет.Получить("ОфициальныйЯзык")).Равно("русский"); // РесурсыЛокализации_ru.os
	Ожидаем.Что(Пакет.Получить("Температура.Обозначение")).Равно("°C"); // РесурсыЛокализации.os

КонецПроцедуры

&Тест
Процедура ТестДолжен_ПроверитьПакетыОднойЛокалиНоСРазнымиИменами() Экспорт

	ПакетОсновной = МенеджерРесурсовЛокализации.ПолучитьПакет("РесурсыЛокализации", "ru_RU");
	ПакетКоманды = МенеджерРесурсовЛокализации.ПолучитьПакет("РесурсыЛокализацииКоманд", "ru_RU");
	
	Ожидаем.Что(ПакетОсновной.Получить("СохранитьКак")).Не_().Заполнено();
	Ожидаем.Что(ПакетКоманды.Получить("СохранитьКак")).Равно("Сохранить как");

КонецПроцедуры

&Тест
Процедура ТестДолжен_ПроверитьСборкуГруппыПакетов() Экспорт

	ГруппаПакетов = МенеджерРесурсовЛокализации.ПолучитьПакеты("РесурсыЛокализации, РесурсыЛокализацииКоманд", "ru_RU");
	
	Ожидаем.Что(ГруппаПакетов.Получить("Приветствие")).Равно("Привет!");
	Ожидаем.Что(ГруппаПакетов.Получить("СохранитьКак")).Равно("Сохранить как");

КонецПроцедуры

&Тест
Процедура ТестДолжен_ПроверитьУстановкуПакетаПоУмолчанию() Экспорт

	Пакет = МенеджерРесурсовЛокализации.ПолучитьПакет("РесурсыЛокализации", "de");
	Пакет.ИспользоватьПоУмолчанию();

	Ожидаем.Что(Мультиязычность.ПакетРесурсовПоУмолчанию().Локаль()).Равно("de");
	
КонецПроцедуры

&Тест
Процедура ТестДолжен_ПроверитьПолучениеСтрокиИзПакета() Экспорт

	Пакет = МенеджерРесурсовЛокализации.ПолучитьПакет("РесурсыЛокализации", "de");
	
	Строка = Пакет.ПолучитьСтроку("СтрокаСПараметрами", "Сергей");

	Ожидаем.Что(Строка).Равно("Hallo Сергей!");
	
КонецПроцедуры

&Тест
Процедура ТестДолжен_ПроверитьПолучениеСтрокиИзГруппыПакетов() Экспорт

	ГруппаПакетов = МенеджерРесурсовЛокализации.ПолучитьПакеты("РесурсыЛокализации, РесурсыЛокализацииКоманд", "ru_RU");
	
	Строка = ГруппаПакетов.ПолучитьСтроку("СтрокаСПараметрами", "Сергей");

	Ожидаем.Что(Строка).Равно("Привет, Сергей!");
	
КонецПроцедуры

&Тест
Процедура ТестДолжен_ПроверитьПолучениеСтрокиИзПакетаПоУмолчанию() Экспорт

	Пакет = МенеджерРесурсовЛокализации.ПолучитьПакет("РесурсыЛокализации");
	Пакет.ИспользоватьПоУмолчанию();
	
	Строка = Мультиязычность.ПолучитьСтроку("СтрокаСПараметрами", "Сергей");

	Ожидаем.Что(Строка).Равно("Привет, Сергей!");
	
КонецПроцедуры


&Тест
Процедура ТестДолжен_ПроверитьПолучениеРесурсаИзПакетаПоУмолчанию() Экспорт

	Пакет = МенеджерРесурсовЛокализации.ПолучитьПакет("РесурсыЛокализации");
	Пакет.ИспользоватьПоУмолчанию();
	
	Ресурс = Мультиязычность.ПолучитьРесурс("Прощание");

	Ожидаем.Что(Ресурс).Равно("До свидания");
	
КонецПроцедуры

&Тест
Процедура ТестДолжен_ПроверитьЗаменуВТекстеДляПакета() Экспорт

	Пакет = МенеджерРесурсовЛокализации.ПолучитьПакет("РесурсыЛокализацииКоманд", "en");
	
	Текст = "<input type='button' value='{t(Открыть)}' /></br>
	|<input type='button' value='{t(СохранитьКак)}' /></a>";

	Эталон = "<input type='button' value='Open' /></br>
	|<input type='button' value='Save as...' /></a>";

	Пакет.ЗаполнитьШаблон(Текст);

	Ожидаем.Что(Текст).Равно(Эталон);

КонецПроцедуры

&Тест
Процедура ТестДолжен_ПроверитьЗаменуВТекстеДляГруппыПакетов() Экспорт

	Пакет = МенеджерРесурсовЛокализации.ПолучитьПакеты("РесурсыЛокализации, РесурсыЛокализацииКоманд", "en_UK");
	
	Текст = "{t(Приветствие)}</br>
	|<input type='button' value='{t(Открыть)}' /></br>
	|<input type='button' value='{t(СохранитьКак)}' /></a>";

	Эталон = "Hello</br>
	|<input type='button' value='Open' /></br>
	|<input type='button' value='Save as...' /></a>";

	Пакет.ЗаполнитьШаблон(Текст);

	Ожидаем.Что(Текст).Равно(Эталон);

КонецПроцедуры