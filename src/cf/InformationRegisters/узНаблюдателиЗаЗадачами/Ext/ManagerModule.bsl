﻿
Процедура СледитьЗаЗадачей(ДопПараметры) Экспорт
	ДобавитьУдалитьНаблюдателя(ДопПараметры,Истина);
КонецПроцедуры 

Процедура ПерестатьСледитьЗаЗадачей(ДопПараметры) Экспорт
	ДобавитьУдалитьНаблюдателя(ДопПараметры,Ложь);
КонецПроцедуры     

Процедура ДобавитьУдалитьНаблюдателя(ДопПараметры,ЭтоДобавление)
	Пользователь = ДопПараметры.Пользователь;
		
	МассивЗадач = ДопПараметры.МассивЗадач;	
	Для каждого ЭлМассиваЗадач из МассивЗадач цикл
		
		Если ЭтоДобавление
			И ЕстьЛиСлежениеЗаЗадачейУПользователя(ЭлМассиваЗадач, Пользователь) Тогда
			Продолжить;
		Конецесли;
		
		МенеджерЗаписи = РегистрыСведений.узНаблюдателиЗаЗадачами.СоздатьМенеджерЗаписи();
		МенеджерЗаписи.Пользователь = Пользователь;
		МенеджерЗаписи.Задача = ЭлМассиваЗадач;
		Если ЭтоДобавление Тогда
			МенеджерЗаписи.Записать();
			Сообщить("Вы следите за задачей #"+ЭлМассиваЗадач.Код + " "+ЭлМассиваЗадач);
		Иначе
			МенеджерЗаписи.Удалить();
			Сообщить("Вы больше не следите за задачей #"+ЭлМассиваЗадач.Код + " "+ЭлМассиваЗадач);
		Конецесли;
	Конеццикла;	
КонецПроцедуры 

Функция ЕстьЛиСлежениеЗаЗадачейУПользователя(Задача, Пользователь) Экспорт 
	ЕстьСлежение = Ложь;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	узНаблюдателиЗаЗадачами.Пользователь,
	|	узНаблюдателиЗаЗадачами.Задача
	|ИЗ
	|	РегистрСведений.узНаблюдателиЗаЗадачами КАК узНаблюдателиЗаЗадачами
	|ГДЕ
	|	узНаблюдателиЗаЗадачами.Задача = &Задача
	|	И узНаблюдателиЗаЗадачами.Пользователь = &Пользователь";
	
	Запрос.УстановитьПараметр("Задача", Задача);
	Запрос.УстановитьПараметр("Пользователь", Пользователь);
	
	РезультатЗапроса = Запрос.Выполнить();
	Если НЕ РезультатЗапроса.Пустой() Тогда 
		ЕстьСлежение = Истина;	
	Конецесли;

	Возврат ЕстьСлежение;	
КонецФункции 

Функция ЕстьЛиСлежениеЗаЗадачейУТекущегоПользователя(Задача) Экспорт
	Возврат ЕстьЛиСлежениеЗаЗадачейУПользователя(Задача, Пользователи.ТекущийПользователь());
КонецФункции 