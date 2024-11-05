#Область ОбработчикиСобытийФормы
&НаКлиенте
Процедура ПриОткрытии(Отказ)

	ПолеHTMLДокумента = "<!DOCTYPE html>
						|<html lang='ru'>
						|<head>
						| <meta charset='utf-8'>
						|  <meta http-equiv='X-UA-Compatible' content='IE=edge'>
						| </head>
						|
						| <body>" + Объект.ТекстШаблонаОтправкиEmail + "</body>
																	   |
																	   |</html>";
КонецПроцедуры
#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы
&НаКлиенте
Процедура ТекстШаблонаОтправкиEmailПриИзменении(Элемент)

	ПолеHTMLДокумента = "<!DOCTYPE html>
						|<html lang='ru'>
						|<head>
						| <meta charset='utf-8'>
						|  <meta http-equiv='X-UA-Compatible' content='IE=edge'>
						| </head>
						|
						| <body>" + Объект.ТекстШаблонаОтправкиEmail + "</body>
																	   |
																	   |</html>";

КонецПроцедуры

&НаКлиенте
Процедура ПланируемаяРаботаПриИзменении(Элемент)
	ПланируемаяРаботаПриИзмененииНаСервере();
КонецПроцедуры
#КонецОбласти

#Область СлужебныеПроцедурыИФункции
&НаСервере
Процедура ПланируемаяРаботаПриИзмененииНаСервере()

	Объект.ПараметрыСообщения.Очистить();

	Если ЗначениеЗаполнено(Объект.ВидШаблона) Тогда
		ПараметрыОтправки = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.ВидШаблона, "ПараметрыОтправки");
		Объект.ПараметрыСообщения.Загрузить(ПараметрыОтправки.Выгрузить());
	КонецЕсли;

КонецПроцедуры
#КонецОбласти