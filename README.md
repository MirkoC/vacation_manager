### Vacation Manager

##### Headers

`Authorization: Bearer %some_jwt_token%` _(Not used for `register` and `session endpoints`, only with `vacations` endpoint)_
`Content-Type`: `application/json`

##### Registration `POST /managers`

Base url: `https://vacation-manager.herokuapp.com`

**Example body**
``` json
{
  "email": "email@example.com",
  "password": "12345678",
  "password_confirmation": "12345678",
  "full_name": "Exambpe Name"
}
```

##### Login `POST /managers/sign_in`

**Example body**
``` json
{
  "email": "email@example.com",
  "password": "12345678"
}
```

#### Vacations endpoint `POST /vacations`

Required params: `stard_date`, `end_date`, `manager_id` or `worker_id`

**Example body**

```json
{
  "manager_id": 6,
  "start_date": "2017-11-11",
  "end_date": "2017-11-21"
}
```
