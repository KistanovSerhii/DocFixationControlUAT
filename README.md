# DocFixationControlUAT
Контроль проведения документов, проверка ws при проведении из 1С:УАТ на наличие справочника "Виды работ" в 1С:ЗУП

DocFixationControlUAT
Расширение для 1С УТ
Контекст
1С:Предприятие 8.3 (8.3.20.1674)
Управление автотранспортом Стандарт, редакция 2.2 (2.2.15.1)
Описание
Наименование: "КонтрольПроведения"

Префикс имени: "КПроведения_"

Основной режим запуска: "Управляемое приложение"

Контроль проведения документов, проверка на наличие кода справочника "Виды работ" в базе 1С:ЗУП (в другой базе)

Проверка выполняется с использованием объекта web service

Реализация расширения предусматривает маштабирование (переиспользование методов) что позволяет добавить контроль
для любых других объектов, событий и по любым другим условиям.

# Детали
+ Проведение документа уатПутевойЛист отлавливает подписка на событие
+ Подписка на событие вызывает процедуру которая Если ТЧ.Задание заполнено
  Вызывает Процедуру проверки куда передает "Отказ"
+ Проверка выполняется средствами WS через запрос

#Запрос

    "Выбрать
	  |	ВидыРабот.Ссылка,
	  |	ВидыРабот.Код КАК Код
	  |	ПОМЕСТИТЬ ВидыРаботВТ
	  |Из
	  |	Справочник.ВидыРаботСотрудников КАК ВидыРабот
	  |ГДЕ
	  |	ВидыРабот.Код В (&ВидРаботКод)
	  |
	  |;

	  |Выбрать Первые 1
	  |	ВидыРаботВТ.Код КАК ВидРаботКод
	  |Из
	  |	РегистрСведений.Массандра_НормыОбъемаРабот КАК Нормы
	  |	ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВидыРаботВТ
	  |	ПО Нормы.ВидРабот = ВидыРаботВТ.Ссылка
	  |ГДЕ
	  |	НАЧАЛОПЕРИОДА(Нормы.Период, Год) = НАЧАЛОПЕРИОДА(&ГодТехКарты, Год)"
