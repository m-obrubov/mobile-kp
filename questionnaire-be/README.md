# questionnaire-be 
Сервис для хранения, обработки и обеспечения данными мобильных приложений с опросами для курсового проекта по дисциплине "Основы разработки мобильных приложений", 2018

## Спецификация

* Платформа: Java
* Технология: Spring Boot
* Хранение данных: PostgreSQL, JPA
* Протокол обмена: http/https
* Формат передачи данных: JSON
* Архитектура: RESTful API
* Аутентификация: JWT-token

## Особенности

* Для доступа к закрытым методам необходимо в заголовке запроса отсылать JWT-токен (header name – «Authorization»).
* Хранится только один опрос на каждую тему, при добавлении ещё одного опроса такой же темы предыдущий удаляется.
* При удалении опроса также удаляются все результаты для этого опроса
* В системе присутствует две роли пользователей:
  * **Student** - отвечает на вопросы опросников
  * **Teacher** - создаёт опросы, просматривает и анализирует статистику

## Константы

**Пол пользователя:**
* `MALE` - мужчина
* `FEMALE` - женщина

**Темы опросов (на латинице):**
* `KOT` - краткий отборочный тест
* `OHRANA_TRUDA` - экзамен по "Охране труда"
* `ELECTROBEZOPASNOST` - экзамен по "Электробезопасности"
* `MMPI` - Миннесотский многоаспектный личностный опросник MMPI
* `SOLOMIN` - тест для оценки профессиональных интересов по методике Соломина
* `KETTELL` - тест для оценки индивидуально-психологических особенностей личности (Тест Кеттелла 16PF)

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
    
### account/token
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

### account/logout
_Выход текущего пользователя из системы_

**Метод:** GET

**Доступ:** all

**Запрос:** none

**Ответ:** none

## USER

### user/all
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
        }
    ]
}
```

### user/id
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
### user/data
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

### user/update
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

## TEST

### test/add
_Добавление опроса_

**Метод:** POST

**Доступ:** teacher

**Тело запроса:**
```json
{
    "test": {
        "id": 1,
        "name": "Экзамен по охране труда",
        "description": "Это экзамен по охране труда...",
        "theme": "OHRANA_TRUDA",
        "questions": [
            {
                "id": 1,
                "value": "Что такое охрана труда?",
                "description": "Вопрос номер один в студии.",
                "number_in_order": 1,
                "is_multi_choice": "false",
                "answers": [
                    {
                        "id": 1,
                        "value": "Это правила поведения на работе, чтобы ты не помер в процессе.",
                        "description": "Вариант номер раз.",
                        "weight": 1
                    }
                ]
            }
        ],
        "results": [
            {
                "id": 1,
                "value": "Вы не сдали экзамен. Поздравляем!",
                "description": "Результат номер раз",
                "points_from": 0,
                "points_to": 50
            }
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

### test/delete
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

### test/all
_Получение списка всех опросов_

**Метод:** GET

**Доступ:** teacher

**Запрос:** none

**Ответ:**
```json
{
    "tests": [
        {
            "id": 1,
            "name": "Экзамен по охране труда",
            "description": "Это экзамен по охране труда...",
            "theme": "OHRANA_TRUDA",
            "questions": [
                {
                    "id": 1,
                    "value": "Что такое охрана труда?",
                    "description": "Вопрос номер один в студии.",
                    "number_in_order": 1,
                    "is_multi_choice": "false",
                    "answers": [
                        {
                            "id": 1,
                            "value": "Это правила поведения на работе, чтобы ты не помер в процессе.",
                            "description": "Вариант номер раз.",
                            "weight": 1
                        }
                    ]
                }
            ],
            "results": [
                {
                    "id": 1,
                    "value": "Вы не сдали экзамен. Поздравляем!",
                    "description": "Результат номер раз",
                    "points_from": 0,
                    "points_to": 50
                }
            ]
        }
    ]
}
```

### test/by_theme
_Получение одного опроса определенной тематики_

**Метод:** GET

**Доступ:** all

**Параметры запроса:**
* **theme** - тема опроса _(Возможные темы опросов перечислены в разделе [Константы](#Константы))_

**Ответ:**
```json
{
    "id": 1,
    "name": "Экзамен по охране труда",
    "description": "Это экзамен по охране труда...",
    "theme": "OHRANA_TRUDA",
    "questions": [
        {
            "id": 1,
            "value": "Что такое охрана труда?",
            "description": "Вопрос номер один в студии.",
            "number_in_order": 1,
            "is_multi_choice": "false",
            "answers": [
                {
                    "id": 1,
                    "value": "Это правила поведения на работе, чтобы ты не помер в процессе.",
                    "description": "Вариант номер раз.",
                    "weight": 1
                }
            ]
        }
    ],
    "results": [
        {
            "id": 1,
            "value": "Вы не сдали экзамен. Поздравляем!",
            "description": "Результат номер раз",
            "points_from": 0,
            "points_to": 50
        }
    ]
}
```

## RESULT

### result/add
_Добавление результата пройденного тестирования текущим пользователем, вошедшим в систему_

**Метод:** POST

**Доступ:** student

**Тело запроса:**
```json
{
    "result": {
        "test": {
            "id": 1,
            "questions": [],
            "results": []
        },
        "total_points": 120,
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
}

```

**Ответ:**
```json
{
    "status": "ok"
}
```

### result/own
_Получение всех результатов опросов для текущего пользователя, вошедшего в систему_

**Метод:** GET

**Доступ:** student

**Запрос:** none

**Ответ:**
```json
{
    "results": [
        {
            "passed_at": "2018-08-30 12:09:04",
            "test": {
                "id": 1,
                "name": "Экзамен по охране труда",
                "description": "Это экзамен по охране труда...",
                "theme": "OHRANA_TRUDA",
                "questions": [],
                "results": []
            },
            "user": {
                "id": 5,
                "first_name": "Ivan",
                "last_name": "Ivanov",
                "age": 25,
                "gender": "MALE",
                "email": "simple@email.com",
                "created_at": "2018-08-30 12:09:04"
            },
            "total_points": 120,
            "question_results": [
                {
                    "question": {
                        "id": 1,
                        "value": "Что такое охрана труда?",
                        "description": "Вопрос номер один в студии.",
                        "number_in_order": 1,
                        "is_multi_choice": "false",
                        "answers": []
                    },
                    "answer": {
                        "id": 1,
                        "value": "Это правила поведения на работе, чтобы ты не помер в процессе.",
                        "description": "Вариант номер раз.",
                        "weight": 1
                    }
                }
            ]
        }
    ]
}
```

### result/all
_Получение результатов всех опросов по всем темам от всех пользователей_

**Метод:** GET

**Доступ:** teacher

**Запрос:** none

**Ответ:** 
```json
{
    "results": [
        {
            "passed_at": "2018-08-30 12:09:04",
            "test": {
                "id": 1,
                "name": "Экзамен по охране труда",
                "description": "Это экзамен по охране труда...",
                "theme": "OHRANA_TRUDA",
                "questions": [],
                "results": []
            },
            "user": {
                "id": 5,
                "first_name": "Ivan",
                "last_name": "Ivanov",
                "age": 25,
                "gender": "MALE",
                "email": "simple@email.com",
                "created_at": "2018-08-30 12:09:04"
            },
            "total_points": 120,
            "question_results": [
                {
                    "question": {
                        "id": 1,
                        "value": "Что такое охрана труда?",
                        "description": "Вопрос номер один в студии.",
                        "number_in_order": 1,
                        "is_multi_choice": "false",
                        "answers": []
                    },
                    "answer": {
                        "id": 1,
                        "value": "Это правила поведения на работе, чтобы ты не помер в процессе.",
                        "description": "Вариант номер раз.",
                        "weight": 1
                    }
                }
            ]
        }
    ]
}
```

### result/theme
_Получение всех результатов опросов по определенной тематике от всех пользователей_

**Метод:** GET

**Доступ:** teacher

**Параметры запроса:**
* **theme** - тема опроса _(Возможные темы опросов перечислены в разделе [Константы](#Константы))_

**Ответ:**
```json
{
    "results": [
        {
            "passed_at": "2018-08-30 12:09:04",
            "test": {
                "id": 1,
                "name": "Экзамен по охране труда",
                "description": "Это экзамен по охране труда...",
                "theme": "OHRANA_TRUDA",
                "questions": [],
                "results": []
            },
            "user": {
                "id": 5,
                "first_name": "Ivan",
                "last_name": "Ivanov",
                "age": 25,
                "gender": "MALE",
                "email": "simple@email.com",
                "created_at": "2018-08-30 12:09:04"
            },
            "total_points": 120,
            "question_results": [
                {
                    "question": {
                        "id": 1,
                        "value": "Что такое охрана труда?",
                        "description": "Вопрос номер один в студии.",
                        "number_in_order": 1,
                        "is_multi_choice": "false",
                        "answers": []
                    },
                    "answer": {
                        "id": 1,
                        "value": "Это правила поведения на работе, чтобы ты не помер в процессе.",
                        "description": "Вариант номер раз.",
                        "weight": 1
                    }
                }
            ]
        }
    ]
}
```

### result/user
_Получение списка всех результатов опросов всех тематик для определеного пользователя_

**Метод:** GET

**Доступ:** teacher

**Параметры запроса:**
* **id** - идентификатор пользователя

**Ответ:**
```json
{
    "results": [
        {
            "passed_at": "2018-08-30 12:09:04",
            "test": {
                "id": 1,
                "name": "Экзамен по охране труда",
                "description": "Это экзамен по охране труда...",
                "theme": "OHRANA_TRUDA",
                "questions": [],
                "results": []
            },
            "user": {
                "id": 5,
                "first_name": "Ivan",
                "last_name": "Ivanov",
                "age": 25,
                "gender": "MALE",
                "email": "simple@email.com",
                "created_at": "2018-08-30 12:09:04"
            },
            "total_points": 120,
            "question_results": [
                {
                    "question": {
                        "id": 1,
                        "value": "Что такое охрана труда?",
                        "description": "Вопрос номер один в студии.",
                        "number_in_order": 1,
                        "is_multi_choice": "false",
                        "answers": []
                    },
                    "answer": {
                        "id": 1,
                        "value": "Это правила поведения на работе, чтобы ты не помер в процессе.",
                        "description": "Вариант номер раз.",
                        "weight": 1
                    }
                }
            ]
        }
    ]
}
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