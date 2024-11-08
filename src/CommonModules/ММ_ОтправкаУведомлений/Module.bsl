#Область ПрограммныйИнтерфейс
// Отправить сообщение телеграм.
// 
// Параметры:
//  СhatId - Строка - id чата в которое вы хотите отправить уведомление.
//  Text - Строка - Текст сообщения
//  Форматированное - Булево - Форматированное
//  ТихаяОтправка   - Булево - Отправить сообщение тихо, без уведомлений.
// 
// Возвращаемое значение:
//  Структура - Отправить сообщение
Функция ОтправитьСообщениеТелеграм(СhatId, Text, Форматированное = Истина, ТихаяОтправка = Ложь) Экспорт

//ТекстСообщения = "<b>b</b>, <strong>Strong</strong>
//        |<i>i</i>, <em>em%1</em>
//        |<a href=""https://infostart.ru/"">Ссылка на Infostart</a>
//        |<code>встроенный код фиксированной ширины встроенный код фиксированной ширины встроенный код фиксированной ширины</code>
//        |<pre>предварительно отформатированный кодовый блок  фиксированной  ширины</pre>";
	Токен = Константы.ММ_ТокенТелеграмБот.Получить();
	Адрес = Константы.ММ_АдресТелеграмАПИ.Получить();

	НужноФорматировать = ?(Форматированное, "&parse_mode=HTML", "");
	НужноОтправитьТихо = ?(ТихаяОтправка, "&disable_notification=true", "");

	ЗапросВБД = СтрШаблон("%1/bot%2/sendMessage?chat_id=%3&text=%4%5%6", Адрес, Токен, СhatId, КодироватьСтроку(Text,
		СпособКодированияСтроки.КодировкаURL), НужноФорматировать, НужноОтправитьТихо);

	Result = ММ_Коннектор.Get(ЗапросВБД);

	Возврат Result;

КонецФункции

// Отправить сообщение на почту.
// 
// Параметры:
//  Адресаты - Массив из Структура -  Массив структур Адрес, представление.
//  * Адрес         - Строка - почтовый адрес (должно быть обязательно заполнено).
//  * Представление - Строка - имя адресата.
//  ТемаПисьма - Строка -  Тема письма
//  СодержаниеПисьма - Строка - Содержание письма в формате HTML
// 
// Возвращаемое значение:
//  Структура - Отправить сообщение на почту:
// * ОК - Булево - 
// * ТекстОшибки - Строка - Текст ошибки, в случае если отправка не удастся.
//@skip-check doc-comment-field-in-description-suggestion
Функция ОтправитьСообщениеНаПочту(Адресаты, ТемаПисьма, СодержаниеПисьма) Экспорт
	Ответ = Новый Структура("ОК, ТекстОшибки", Истина, "");

	ПочтаДляОтправкиУведомления = Константы.ММ_УчетнаяЗаписьПочты.Получить();

	ПараметрыПисьма = Новый Структура;
	ПараметрыПисьма.Вставить("Кому");
	ПараметрыПисьма.Вставить("Тема");
	ПараметрыПисьма.Вставить("Тело");
	ПараметрыПисьма.Вставить("Важность");
	ПараметрыПисьма.Вставить("УведомитьОПрочтении");
	ПараметрыПисьма.Вставить("ТипТекста");
	ПараметрыПисьма.Вставить("АдресОтвета");

	ПараметрыПисьма.АдресОтвета = Адресаты; //("");  
	ПараметрыПисьма.Кому = Адресаты;
	ПараметрыПисьма.Тема = ТемаПисьма;
	ПараметрыПисьма.Тело = СодержаниеПисьма;
	ПараметрыПисьма.Важность = ВажностьИнтернетПочтовогоСообщения.Наивысшая;
	ПараметрыПисьма.УведомитьОПрочтении = Истина;

	ПараметрыПисьма.ТипТекста = Перечисления.ТипыТекстовЭлектронныхПисем.HTMLСКартинками;

	Письмо = РаботаСПочтовымиСообщениями.ПодготовитьПисьмо(ПочтаДляОтправкиУведомления, ПараметрыПисьма);
	Попытка
		РаботаСПочтовымиСообщениями.ОтправитьПисьмо(ПочтаДляОтправкиУведомления, Письмо);

	Исключение
		Ответ.ОК = Ложь;
		Ответ.ТекстОшибки = ОбработкаОшибок.КраткоеПредставлениеОшибки(ИнформацияОбОшибке());
	КонецПопытки;
	Возврат Ответ;
КонецФункции

#КонецОбласти