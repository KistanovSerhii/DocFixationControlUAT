﻿
#Область ПрограммныйИнтерфейс

// Функция - Послать запрос
//
// Параметры:
// 	НастройкиПрокси	 - Структура ИЗ
//		*ИмяСервера 		- Строка - url сервера где опубликован WS ("http://192.168.171.203:8012/")
//		*ИмяБазы			- Строка - Имя базы ИБ в которой обк ws к которому мы обращаемя ("zup")
//		*ИмяWS				- Строка - Имя файла публикации (без расширения, "Bugs_uat_zup")
//		*ПространствоИмен	- Строка - URL пространство имен (см. у обк ws "http://www.mass_uat_zup.com")
//
//  ТекстЗапроса	 - Строка - Описывает запрос к данным.
//  Параметры		 - Структура - Параметры для запроса.
//  ТипОбходаЗапроса - Строка - "ПоГруппировкам", ПоГруппировкамСИерархией", "Прямой"
//	(это тип "ОбходРезультатаЗапроса" так как на стороне ws сервера будет выполнена Выгрузка запроса)
// 
// Возвращаемое значение:
//  Ответ - ЗначениеИзСтрокиВнутр - Произвольный (Таблица значений так как это выгрузка запроса)
//
&НаСервере
Функция ПослатьЗапросWS(НастройкиПрокси, ТекстЗапроса, ПараметрыWS = "", ТипОбходаЗапроса = "Прямой") Экспорт

	ИмяСервера 			= НастройкиПрокси.ИмяСервера;
	ИмяБазы 			= НастройкиПрокси.ИмяБазы;
	ИмяWS 				= НастройкиПрокси.ИмяWS;
    ПространствоИмен 	= НастройкиПрокси.ПространствоИмен;
	
	Попытка
		
		WSОпределение 		= Новый WSОпределения(ИмяСервера + ИмяБазы + "/ws/" + ИмяWS + ".1cws/?wsdl");
		Прокси 				= Новый WSПрокси(WSОпределение, ПространствоИмен , ИмяWS, ИмяWS + "Soap");
	    
    	стрПараметры 		= ЗначениеВСтрокуВнутр(ПараметрыWS);	
		ОтветWS 			= Прокси.ВыполнитьЗапрос(ТекстЗапроса, стрПараметры, ТипОбходаЗапроса);
	
		Ответ 				= ЗначениеИзСтрокиВнутр(ОтветWS);
	
	Исключение
		Ответ 				= Неопределено;
	КонецПопытки;    
	
	Возврат Ответ;
	
КонецФункции

&НаСервере
Функция НовыйНастройкиПрокси_Bugs_uat_zup() Экспорт
	
	НастройкиПрокси = Новый Структура;
	
	НастройкиПрокси.Вставить("ИмяСервера", 		 "http://192.168.171.203:8012/");
	НастройкиПрокси.Вставить("ИмяБазы", 		 "zup");
	НастройкиПрокси.Вставить("ИмяWS", 			 "Bugs_uat_zup");
    НастройкиПрокси.Вставить("ПространствоИмен", "http://www.mass_uat_zup.com");
	
	Возврат НастройкиПрокси;
	
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс
#КонецОбласти

#Область СлужебныеПроцедурыИФункции
#КонецОбласти