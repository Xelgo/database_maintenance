#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
#Область ОбработчикиСобытий
Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Если ЭтоГруппа Тогда
	Возврат;
	КонецЕсли;
	Если СпособОбновления <> Перечисления.ММ_СпособыОбновления.ИзФайлаCf Тогда
		ПроверяемыеРеквизиты.Удалить(ПроверяемыеРеквизиты.Найти("ПутьДоФайлаCf"));
	КонецЕсли;

	Если СпособОбновления <> Перечисления.ММ_СпособыОбновления.ИзХранилищаКонфигурации Тогда
		ПроверяемыеРеквизиты.Удалить(ПроверяемыеРеквизиты.Найти("ПутьДоХранилища"));
		ПроверяемыеРеквизиты.Удалить(ПроверяемыеРеквизиты.Найти("ЛогинХранилище"));
	КонецЕсли;

	Если ТипБазы <> Перечисления.ММ_ТипБазы.Файловая Тогда
		ПроверяемыеРеквизиты.Удалить(ПроверяемыеРеквизиты.Найти("ПутьДоФайловойбазы"));
	КонецЕсли;

	Если ТипБазы <> Перечисления.ММ_ТипБазы.Серверная Тогда
		ПроверяемыеРеквизиты.Удалить(ПроверяемыеРеквизиты.Найти("ИмяБазы"));
	КонецЕсли;

	Если ТипБазы = Перечисления.ММ_ТипБазы.Серверная И Владелец = Справочники.ММ_Кластер1С.ФайловаяБаза Тогда
		ОбщегоНазначения.СообщитьПользователю("Файловая база не может быть кластером для серверного вида базы",
			ЭтотОбъект, "Владелец" , , Отказ);

	КонецЕсли;

КонецПроцедуры
#КонецОбласти

#КонецЕсли