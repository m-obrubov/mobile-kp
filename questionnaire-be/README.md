# questionnaire-be 
Сервис для хранения, обработки и обеспечения данными мобильных приложений с опросами для курсового проекта по дисциплине "Основы разработки мобильных приложений", 2018

## Описание

В системе присутствует две роли:
* **Student** - отвечает на вопросы опросников
* **Teacher** - создаёт тесты, просматривает и анализирует статистику

## Спецификация

* Протокол обмена: http/https
* Формат передачи данных: JSON
* Архитектура API: REST
* Аутентификация: JWT-token

## Особенности

* Для доступа к закрытым методам необходимо в заголовке запроса отсылать JWT-токен (header name – «Authorization»).
* Хранится только один тест на каждую тему, при добавлении ещё одного теста предыдущий удаляется.
* Пол пользователя представлен константой и может принимать значения `MALE` и `FEMALE`

# API

## ACCOUNT

### account/register 
_Регистрация нового пользователя в системе_

**Метод:** POST

**Доступ:** all

**Тело запроса:**

```
{
	'first_name': 'Ivan',
	'last_name': 'Ivanov',
	'age': '25',
	'gender': 'MALE',
	'email': 'simple@email.com',
	'password': 'qweasdzxc'
}
```
**Ответ:** none
	
### account/login
_Аутентификация и авторизация пользователя_

**Метод:** POST

**Доступ:** all

**Параметры запроса:** 
* **login** - E-mail, указанный при регистрации (Например, `simple@email.com`)
* **password** - пароль

**Ответ:**
```
{
	'user': {
		'id': 5,
		'first_name': 'Ivan',
		'last_name': 'Ivanov',
		'age': '25',
		'gender': 'MALE',
		'email': 'simple@email.com',
		'created_at': '2018-08-30 12:09:04'
	}
}
```

### account/logout
_Выход текущего пользователя из системы_

**Метод:** GET

**Доступ:** all

**Запрос:** none

**Ответ:** none

## USER

## user/all
_Получение информации всех пользователей **с ролью student**_

**Метод:** GET

**Доступ:** teacher

**Запрос:** none

**Ответ:** 
```
{
	'users': [
		{
			'id': 5,
			'first_name': 'Ivan',
			'last_name': 'Ivanov',
			'age': '25',
			'gender': 'MALE',
			'email': 'simple@email.com',
			'created_at': '2018-08-30 12:09:04'
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
```
{
	'user': {
		'id': 5,
		'first_name': 'Ivan',
		'last_name': 'Ivanov',
		'age': '25',
		'gender': 'MALE',
		'email': 'simple@email.com',
		'created_at': '2018-08-30 12:09:04'
	}
}
```
## user/data
_Получение информации текущего пользователя, вошедшего в систему_

**Метод:** GET

**Доступ:** student

**Запрос:** none

**Ответ:**
```
{
	'user': {
		'id': 5,
		'first_name': 'Ivan',
		'last_name': 'Ivanov',
		'age': '25',
		'gender': 'MALE',
		'email': 'simple@email.com',
		'created_at': '2018-08-30 12:09:04'
	}
}
```

## user/update
_Обновление информации для текущего пользователя, вошедшего в систему_

**Метод:** PUT

**Доступ:** student

**Тело запроса:**

* _В запрос попадают только те поля, которые требуют обновления_
* _поле id **обязательно**_
```
{
	'user': {
		'id': 5,
		'first_name': 'New Ivan',
		'age': '26',
	}
}
```

**Ответ:**
```
{
	'user': {
		'id': 5,
		'first_name': 'New Ivan',
		'last_name': 'Ivanov',
		'age': '26',
		'gender': 'MALE',
		'email': 'simple@email.com',
		'created_at': '2018-08-30 12:09:04'
	}
}
```

# _В разработке..._

**Метод:** GET

**Доступ:** all

**Запрос:** none

**Ответ:** none

### TEST

test/add
	method: POST
	in: full test
	out: ok
	permission: teacher
	description: 
test/delete
	method: DELETE
	in: test theme
	out: ok
	permission: teacher
	description:
test/all
	method: GET
	in: none
	out: list tests
	permission: teacher
	description:
test/by_theme
	method: GET
	in: theme
	out: full test
	permission: student
	description:

---------------------
### RESULT

result/add
	method: POST
	in: full test result
	out: ok
	permission: student
	description:
result/own
	method: GET
	in: none
	out: list test result
	permission: student
	description: returns results of all tests for current logged-in user
result/all
	method: GET
	in: none
	out: list test result
	permission: teacher
	description:
result/theme
	method: GET
	in: theme
	out: list test result
	permission: teacher
	description:
result/user
	method: GET
	in: user id
	out: list test result
	permission: teacher
	description: