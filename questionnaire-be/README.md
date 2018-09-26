# questionnaire-be 
Сервис для хранения, обработки и обеспечения данными мобильных приложений с опросами для курсового проекта по дисциплине "Основы разработки мобильных приложений", 2018

## Спецификация

* Протокол обмена: http/https
* Формат передачи данных: JSON
* Архитектура API: REST
* Аутентификация: JWT-token

## Особенности

* Для доступа к закрытым методам необходимо в заголовке запроса отсылать JWT-токен (header name – «Authorization»).
* Хранится только один тест на каждую тему, при добавлении ещё одного теста предыдущий удаляется.
* Пол пользователя представлен константой и может принимать значения `MALE` и `FEMALE`

## Константы

**Роли пользователей:**
* **Student** - отвечает на вопросы опросников
* **Teacher** - создаёт тесты, просматривает и анализирует статистику

**Пол пользователя:**
* `MALE` - мужчина
* `FEMALE` - женщина

**Темы опросов:**
* 
# API

## ACCOUNT

### account/register 
_Регистрация нового пользователя в системе_

**Метод:** POST

**Доступ:** all

**Тело запроса:**

```json
{
	"first_name": "Ivan",
	"last_name": "Ivanov",
	"age": 25,
	"gender": "MALE",
	"email": "simple@email.com",
	"password": "qweasdzxc"
}
```
**Ответ:** 
```json
{
	"status": "ok"
}
```
	
### account/login
_Аутентификация и авторизация пользователя_

**Метод:** POST

**Доступ:** all

**Параметры запроса:** 
* **login** - E-mail, указанный при регистрации (Например, `simple@email.com`)
* **password** - пароль

**Ответ:**
```json
{
	"user": {
		"id": 5,
		"first_name": "Ivan",
		"last_name": "Ivanov",
		"age": 25,
		"gender": "MALE",
		"email": "simple@email.com",
		"created_at": "2018-08-30 12:09:04"
	}
}
```

### account/logout
_Выход текущего пользователя из системы_

**Метод:** GET

**Доступ:** all

**Запрос:** none

**Ответ:**
```json
{
	"status": "ok"
}
```

## USER

## user/all
_Получение информации всех пользователей **с ролью student**_

**Метод:** GET

**Доступ:** teacher

**Запрос:** none

**Ответ:** 
```json
{
	"users": [
		{
			"id": 5,
			"first_name": "Ivan",
			"last_name": "Ivanov",
			"age": 25,
			"gender": "MALE",
			"email": "simple@email.com",
			"created_at": "2018-08-30 12:09:04"
		},
		{
			...
		},
		...
	]
}
```

## user/id
_Получение информации о пользователе **с ролью student** по его идентификатору_

**Метод:** GET

**Доступ:** teacher

**Параметры запроса:** 
* **id** - идентификатор пользователя

**Ответ:** 
```json
{
	"user": {
		"id": 5,
		"first_name": "Ivan",
		"last_name": "Ivanov",
		"age": 25,
		"gender": "MALE",
		"email": "simple@email.com",
		"created_at": "2018-08-30 12:09:04"
	}
}
```
## user/data
_Получение информации текущего пользователя, вошедшего в систему_

**Метод:** GET

**Доступ:** student

**Запрос:** none

**Ответ:**
```json
{
	"user": {
		"id": 5,
		"first_name": "Ivan",
		"last_name": "Ivanov",
		"age": 25,
		"gender": "MALE",
		"email": "simple@email.com",
		"created_at": "2018-08-30 12:09:04"
	}
}
```

## user/update
_Обновление информации для текущего пользователя, вошедшего в систему_

**Метод:** PUT

**Доступ:** student

**Тело запроса:**

* _В запросе должны быть только те поля, которые требуют обновления_
* _поле id **обязательно**_
```json
{
	"user": {
		"id": 5,
		"first_name": "New Ivan",
		"age": 26,
	}
}
```

**Ответ:**
```json
{
	"user": {
		"id": 5,
		"first_name": "New Ivan",
		"last_name": "Ivanov",
		"age": 26,
		"gender": "MALE",
		"email": "simple@email.com",
		"created_at": "2018-08-30 12:09:04"
	}
}
```

### TEST

## test/add
_Добавление опроса_

**Метод:** POST

**Доступ:** teacher

**Запрос:**
```json
{
	"test": {
		"name": "Экзамен по охране труда",
		"description": "Это экзамен по охране труда...",
		"theme": "OHRANA_TRUDA",
		"questions": [
			{
				"value": "Что такое охрана труда?",
				"description": "Вопрос номер один в студии.",
				"number_in_order": 1,
				"is_multi_choice": "false",
				"answers": [
					{
						"value": "Это правила поведения на работе, чтобы ты не помер в процессе.",
						"description": "Вариант номер раз.",
						"weight": 1
					},
					{
						...
					},
					...
				]
			},
			{
				...
			},
			...
		],
		"results": [
			{
				"value": "Вы не сдали экзамен. Поздравляем!",
				"description": "Результат номер раз",
				"points_from": 0,
				"points_to": 50
			},
			{
				...
			},
			...
		]
	}
}
```

**Ответ:** 
```json
{
	"status": "ok"
}
```

## test/delete
_Удаление опроса определенной тематики_

**Метод:** DELETE

**Доступ:** teacher

**Параметры запроса:** 
* **theme** - тема опроса _(Возможные темы опросов перечислены в разделе [Константы](#Константы))_

**Ответ:**
```json
{
	"status": "ok"
}
```

## test/all
_Получение списка всех опросов_

**Метод:** GET

**Доступ:** teacher

**Запрос:** none

**Ответ:**
```json
{
	"tests": [
		{
			"name": "Экзамен по охране труда",
			"description": "Это экзамен по охране труда...",
			"theme": "OHRANA_TRUDA",
			"questions": [
				{
					"value": "Что такое охрана труда?",
					"description": "Вопрос номер один в студии.",
					"number_in_order": 1,
					"is_multi_choice": "false",
					"answers": [
						{
							"value": "Это правила поведения на работе, чтобы ты не помер в процессе.",
							"description": "Вариант номер раз.",
							"weight": 1
						},
						{
							...
						},
						...
					]
				},
				{
					...
				},
				...
			],
			"results": [
				{
					"value": "Вы не сдали экзамен. Поздравляем!",
					"description": "Результат номер раз",
					"points_from": 0,
					"points_to": 50
				},
				{
					...
				},
				...
			]
		},
		{
			...
		},
		...
	]
}
```

## test/by_theme
_Получение одного опроса определенной тематики_

**Метод:** GET

**Доступ:** all

**Параметры запроса:**
* **theme** - тема опроса _(Возможные темы опросов перечислены в разделе [Константы](#Константы))_

**Ответ:**
```json
{
	"name": "Экзамен по охране труда",
	"description": "Это экзамен по охране труда...",
	"theme": "OHRANA_TRUDA",
	"questions": [
		{
			"value": "Что такое охрана труда?",
			"description": "Вопрос номер один в студии.",
			"number_in_order": 1,
			"is_multi_choice": "false",
			"answers": [
				{
					"value": "Это правила поведения на работе, чтобы ты не помер в процессе.",
					"description": "Вариант номер раз.",
					"weight": 1
				},
				{
					...
				},
				...
			]
		},
		{
			...
		},
		...
	],
	"results": [
		{
			"value": "Вы не сдали экзамен. Поздравляем!",
			"description": "Результат номер раз",
			"points_from": 0,
			"points_to": 50
		},
		{
			...
		},
		...
	]
}
```


# _В разработке..._

**Метод:** GET

**Доступ:** all

**Запрос:** none

**Ответ:** none

### RESULT

## result/add
	method: POST
	in: full test result
	out: ok
	permission: student
	description:
## result/own
	method: GET
	in: none
	out: list test result
	permission: student
	description: returns results of all tests for current logged-in user
## result/all
	method: GET
	in: none
	out: list test result
	permission: teacher
	description:
## result/theme
	method: GET
	in: theme
	out: list test result
	permission: teacher
	description:
## result/user
	method: GET
	in: user id
	out: list test result
	permission: teacher
	description: