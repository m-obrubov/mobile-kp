# questionnaire-be 
Сервис для хранения, обработки и обеспечения данными мобильного приложения "Опросник Соломина" для курсового проекта по дисциплине "Основы разработки мобильных приложений", 2018

## Спецификация

* Платформа: Java
* Технология: Spring Boot
* Хранение данных: PostgreSQL, JPA
* Протокол обмена: http/https
* Формат передачи данных: JSON
* Архитектура: RESTful API
* Аутентификация: JWT-token

## БД
Создание базы и пользователя:
```postgresql
CREATE DATABASE questionnaire;
CREATE USER questionnaire_be_client WITH PASSWORD 'password';
GRANT ALL ON DATABASE questionnaire TO questionnaire_be_client;
```

## Особенности

* Для доступа к закрытым методам необходимо в заголовке запроса отсылать JWT-токен (header name – «Authorization»).
* В системе в любой момент времени хранится только один опрос.
* При удалении опроса также удаляются все результаты для этого опроса.
* В системе присутствует две роли пользователей:
  * **Student** - отвечает на вопросы опросников
  * **Teacher** - создаёт опросы, просматривает и анализирует статистику

## Константы

**Пол пользователя:**
* `MALE` - мужчина
* `FEMALE` - женщина

**Часть теста:**
* `CAN` - Часть "Я могу" 
* `WANT` - Часть "Я хочу"

**Класс профессии:**
* `HUMAN` - предмет труда "человек"
* `TECHNICS` - предмет труда "техника"
* `ZNAK` - предмет труда "знаковая система"
* `ART` - предмет труда "художественный образ"
* `NATURE` - предмет труда "природа"
* `EXECUTOR` - характер труда "исполнительские профессии"
* `CREATOR` - характер труда "творческие профессии"

# API

## ACCOUNT

### /account/register 
_Регистрация нового пользователя в системе_

**Метод:** POST

**Доступ:** all

**Тело запроса:**

```json
{
    "first_name": "Ivan",
    "last_name": "Ivanov",
    "age": 25,
    "city": "Moscow",
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
    
### /account/token
_Получение токена для входа в систему_

**Метод:** POST

**Доступ:** all

**Параметры запроса:** 
* **login** - E-mail, указанный при регистрации (Например, `simple@email.com`)
* **password** - пароль

**Ответ:**
```json
{
    "token": "uhg9rjf09j3g39.gerwewge6joikrr3pww.qwdwr540432r12efgerwfqerq"
}
```

## USER

### /user
_Получение информации текущего пользователя, вошедшего в систему_

**Метод:** GET

**Доступ:** student

**Запрос:** none

**Ответ:**
```json
{
    "id": 5,
    "first_name": "Ivan",
    "last_name": "Ivanov",
    "age": 25,
    "city": "Moscow",
    "gender": "MALE",
    "email": "simple@email.com",
    "created_at": "2018-08-30 12:09:04"
}
```

### /user
_Обновление информации для текущего пользователя, вошедшего в систему_

**Метод:** PUT

**Доступ:** student

**Тело запроса:**

* _В запросе должны быть только те поля, которые требуют обновления_
```json
{
    "first_name": "New Ivan",
    "age": 26
}
```

**Ответ:**
```json
{
    "id": 5,
    "first_name": "New Ivan",
    "last_name": "Ivanov",
    "age": 26,
    "city": "Moscow",
    "gender": "MALE",
    "email": "simple@email.com",
    "created_at": "2018-08-30 12:09:04"
}
```

## TEST

### /test
_Добавление опроса_

**Метод:** POST

**Доступ:** teacher

**Тело запроса:**
```json
{
    "name": "Тест на оценку оценки профессиональных интересов Соломина",
    "about": "Анкета 'Ориентация' определяет профессиональную направленность личности к определенной сфере деятельности.",
    "rules": "В первой части (\"Я хочу\") вы можете оценить по 4-х бальной шкале степень своего желания заниматься...",
    "questions": [
        {
            "value": "Я хочу обслуживать людей",
            "group": "HUMAN",
            "part": "WANT",
            "number_in_order": 1
        }
    ],
    "answers": [
        {
            "value": "Вовсе нет",
            "weight": 0
        },
        {
            "value": "Пожалуй так",
            "weight": 1
        },
        {
            "value": "Верно",
            "weight": 2
        },
        {
            "value": "Совершенно верно",
            "weight": 3
        }
    ],
    "results": [
        {
            "description": "Вы уверенный в себе и амбициозный...",
            "professions": [
                {
                    "value": "Архитектор",
                    "description": "Архитектор строит дома"
                },
                {
                    "value": "Художник",
                    "description": "Художник пишет картины"
                },
                {
                    "value": "Музыкант",
                    "description": "Музыкант пишет музыку"
                },
                {
                    "value": "Хореограф",
                    "description": "Хореограф умеет танцевать"
                }
            ],
            "work_subject": "ART",
            "work_character": "CREATOR"
        }
    ]
}
```

**Ответ:** 
```json
{
    "status": "ok"
}
```

### /test
_Удаление опроса_

**Метод:** DELETE

**Доступ:** teacher

**Запрос:** none

**Ответ:**
```json
{
    "status": "ok"
}
```

### /test
_Получение данных опроса_

**Метод:** GET

**Доступ:** all

**Запрос:** none

**Ответ:**
```json
{
    "id": 1,
    "name": "Тест на оценку оценки профессиональных интересов Соломина",
    "about": "Анкета 'Ориентация' определяет профессиональную направленность личности к определенной сфере деятельности.",
    "rules": "В первой части (\"Я хочу\") вы можете оценить по 4-х бальной шкале степень своего желания заниматься...",
    "questions": [
        {
            "id": 1,
            "value": "Я хочу обслуживать людей",
            "group": "HUMAN",
            "part": "WANT",
            "number_in_order": 1
        }
    ],
    "answers": [
        {
            "id": 1,
            "value": "Вовсе нет",
            "weight": 0
        },
        {
            "id": 2,
            "value": "Пожалуй так",
            "weight": 1
        },
        {
            "id": 3,
            "value": "Верно",
            "weight": 2
        },
        {
            "id": 4,
            "value": "Совершенно верно",
            "weight": 3
        }
    ],
    "results": [
        {
            "id": 1,
            "description": "Вы уверенный в себе и амбициозный...",
            "professions": [
                {
                    "value": "Архитектор",
                    "description": "Архитектор строит дома"
                },
                {
                    "value": "Художник",
                    "description": "Художник пишет картины"
                },
                {
                    "value": "Музыкант",
                    "description": "Музыкант пишет музыку"
                },
                {
                    "value": "Хореограф",
                    "description": "Хореограф умеет танцевать"
                }
            ],
            "work_subject": "ART",
            "work_character": "CREATOR"
        }
    ]
}
```

## RESULT

### /result
_Добавление ответов на вопросы текущим пользователем, вошедшим в систему. В ответ отправляется результат тестирования_

**Метод:** POST

**Доступ:** student

**Тело запроса:**
```json
{
    "test": {
        "id": 1
    },
    "question_results": [
        {
            "question": {
                "id": 1
            },
            "answer": {
                "id": 1
            }
        }
    ]
}


```

**Ответ:**
```json
{
    "passed_at": "2018-08-30 12:09:04",
    "user": {
        "id": 5,
        "first_name": "New Ivan",
        "last_name": "Ivanov",
        "age": 26,
        "city": "Moscow",
        "gender": "MALE",
        "email": "simple@email.com",
        "created_at": "2018-08-30 12:09:04"
    },
    "test": {
        "name": "Тест на оценку оценки профессиональных интересов Соломина",
        "about": "Анкета 'Ориентация' определяет профессиональную направленность личности к определенной сфере деятельности.",
        "rules": "В первой части (\"Я хочу\") вы можете оценить по 4-х бальной шкале степень своего желания заниматься...",
        "questions": [],
        "answers": [],
        "results": []
    },
    "result_can": {
        "description": "Вы уверенный в себе и амбициозный...",
        "professions": [
            {
                "value": "Архитектор",
                "description": "Архитектор строит дома"
            },
            {
                "value": "Художник",
                "description": "Художник пишет картины"
            },
            {
                "value": "Музыкант",
                "description": "Музыкант пишет музыку"
            },
            {
                "value": "Хореограф",
                "description": "Хореограф умеет танцевать"
            }
        ],
        "work_subject": "ART",
        "work_character": "CREATOR"
    },
    "result_want": {
        "description": "Вы уверенный в себе и амбициозный...",
        "professions": [
            {
                "value": "Архитектор",
                "description": "Архитектор строит дома"
            },
            {
                "value": "Художник",
                "description": "Художник пишет картины"
            },
            {
                "value": "Музыкант",
                "description": "Музыкант пишет музыку"
            },
            {
                "value": "Хореограф",
                "description": "Хореограф умеет танцевать"
            }
        ],
        "work_subject": "ART",
        "work_character": "CREATOR"
    },
    "question_results": [
        {
            "question": {
                "id": 1,
                "value": "Я хочу обслуживать людей",
                "group": "HUMAN",
                "part": "WANT",
                "number_in_order": 1
            },
            "answer": {
                "id": 1,
                "value": "Вовсе нет",
                "weight": 0
            }
        }
    ]
}
```

### /result
_Получение всех результатов опросов для текущего пользователя, вошедшего в систему_

**Метод:** GET

**Доступ:** student

**Запрос:** none

**Ответ:**
```json
[
    {
        "passed_at": "2018-08-30 12:09:04",
        "user": {
            "id": 5,
            "first_name": "New Ivan",
            "last_name": "Ivanov",
            "age": 26,
            "city": "Moscow",
            "gender": "MALE",
            "email": "simple@email.com",
            "created_at": "2018-08-30 12:09:04"
        },
        "test": {
            "name": "Тест на оценку оценки профессиональных интересов Соломина",
            "about": "Анкета 'Ориентация' определяет профессиональную направленность личности к определенной сфере деятельности.",
            "rules": "В первой части (\"Я хочу\") вы можете оценить по 4-х бальной шкале степень своего желания заниматься...",
            "questions": [],
            "answers": [],
            "results": []
        },
        "result_can": {
            "description": "Вы уверенный в себе и амбициозный...",
            "professions": [
                {
                    "value": "Архитектор",
                    "description": "Архитектор строит дома"
                },
                {
                    "value": "Художник",
                    "description": "Художник пишет картины"
                },
                {
                    "value": "Музыкант",
                    "description": "Музыкант пишет музыку"
                },
                {
                    "value": "Хореограф",
                    "description": "Хореограф умеет танцевать"
                }
            ],
            "work_subject": "ART",
            "work_character": "CREATOR"
        },
        "result_want": {
            "description": "Вы уверенный в себе и амбициозный...",
            "professions": [
                {
                    "value": "Архитектор",
                    "description": "Архитектор строит дома"
                },
                {
                    "value": "Художник",
                    "description": "Художник пишет картины"
                },
                {
                    "value": "Музыкант",
                    "description": "Музыкант пишет музыку"
                },
                {
                    "value": "Хореограф",
                    "description": "Хореограф умеет танцевать"
                }
            ],
            "work_subject": "ART",
            "work_character": "CREATOR"
        },
        "question_results": [
            {
                "question": {
                    "id": 1,
                    "value": "Я хочу обслуживать людей",
                    "group": "HUMAN",
                    "part": "WANT",
                    "number_in_order": 1
                },
                "answer": {
                    "id": 1,
                    "value": "Вовсе нет",
                    "weight": 0
                }
            }
        ]
    }
]
```

### /result/all
_Получение результатов всех опросов по всем темам от всех пользователей_

**Метод:** GET

**Доступ:** teacher

**Запрос:** none

**Ответ:** 
```json
[
    {
        "passed_at": "2018-08-30 12:09:04",
        "user": {
            "id": 5,
            "first_name": "New Ivan",
            "last_name": "Ivanov",
            "age": 26,
            "city": "Moscow",
            "gender": "MALE",
            "email": "simple@email.com",
            "created_at": "2018-08-30 12:09:04"
        },
        "test": {
            "name": "Тест на оценку оценки профессиональных интересов Соломина",
            "about": "Анкета 'Ориентация' определяет профессиональную направленность личности к определенной сфере деятельности.",
            "rules": "В первой части (\"Я хочу\") вы можете оценить по 4-х бальной шкале степень своего желания заниматься...",
            "questions": [],
            "answers": [],
            "results": []
        },
        "result_can": {
            "description": "Вы уверенный в себе и амбициозный...",
            "professions": [
                {
                    "value": "Архитектор",
                    "description": "Архитектор строит дома"
                },
                {
                    "value": "Художник",
                    "description": "Художник пишет картины"
                },
                {
                    "value": "Музыкант",
                    "description": "Музыкант пишет музыку"
                },
                {
                    "value": "Хореограф",
                    "description": "Хореограф умеет танцевать"
                }
            ],
            "work_subject": "ART",
            "work_character": "CREATOR"
        },
        "result_want": {
            "description": "Вы уверенный в себе и амбициозный...",
            "professions": [
                {
                    "value": "Архитектор",
                    "description": "Архитектор строит дома"
                },
                {
                    "value": "Художник",
                    "description": "Художник пишет картины"
                },
                {
                    "value": "Музыкант",
                    "description": "Музыкант пишет музыку"
                },
                {
                    "value": "Хореограф",
                    "description": "Хореограф умеет танцевать"
                }
            ],
            "work_subject": "ART",
            "work_character": "CREATOR"
        },
        "question_results": [
            {
                "question": {
                    "id": 1,
                    "value": "Я хочу обслуживать людей",
                    "group": "HUMAN",
                    "part": "WANT",
                    "number_in_order": 1
                },
                "answer": {
                    "id": 1,
                    "value": "Вовсе нет",
                    "weight": 0
                }
            }
        ]
    }
]
```

## Ответы ошибок

### 400 - Bad request
**Причины:**
* Неверное наименование параметров
* Отсутствуют какие-либо обязательные параметры
* Значение параметра не входит в область допустимых значений

**Формат:**
```json
{
    "status": "error",
    "code": 400
}
```

### 403 - Permission denied
**Причины:**
* Обращение к методу с невалидной ролью

**Формат:**
```json
{
    "status": "error",
    "code": 403
}
```

### 500 - Internal server error
**Причины:**
* Любая ошибка сервера, не зависит от клиента

**Формат:**
```json
{
    "status": "error",
    "code": 500
}
```