# ULID を使う

- DB を作成しjmなおします。

```shell
bin/rails db:drpp
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed
```

```plain
bin/rails c -s
> User.first.attributes
  User Load (0.6ms)  SELECT `users`.* FROM `users` ORDER BY `users`.`id` ASC LIMIT 1
{
                        "id" => "01G1DB45RT455R6K6XW3R8MQ32",
                     "email" => "guest_0001@example.com",
        "encrypted_password" => "$2a$12$6aIwJvvfGNJ2Tba/V2DguOOS1/5tnob17yJUFqlJOJNJxFb0BQhb6",
      "reset_password_token" => nil,
    "reset_password_sent_at" => nil,
       "remember_created_at" => nil,
                "created_at" => Sun, 24 Apr 2022 08:29:50 UTC +00:00,
                "updated_at" => Sun, 24 Apr 2022 08:29:50 UTC +00:00
}
```

htt@://localhost:3000/user にアクセスしてサインアップします。

## 参考情

<https://zenn.dev/isao_e_dev/articles/93e8e78c02b15a>
[Rails]Model(ActiveRecord)のid(PK)にULIDを用いる

<https://qiita.com/watame/items/c5afc227bf7029826762>
【Rails】ModelのPKをULIDに変更する

<https://qiita.com/jnchito/items/e23b1facc72bd86234b6>
Rails 6.0で"Uniqueness validator will no longer enforce case sensitive comparison in Rails 6.1."という警告が出たときの対処法