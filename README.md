
# テーブル設計

## users テーブル

| Column             | Type   | Options                    |
| ------------------ | ------ | -------------------------- |
| email              | string | null: false, unique: true  |
| encrypted_password | string | null: false                |
| first_name         | string | null: false                |
| family_name        | string | null: false                |
| first_name_kana    | string | null: false                |
| family_name_kana   | string | null: false                |
| birth_day          | date   | null: false                |
| nickname           | string | null: false                |

### Association

- has_many :products
- has_many :purchase_records


## products テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| title              | string     | null: false                    |
| category_id        | integer    | null: false                    |
| condition_id       | integer    | null: false                    |
| price              | integer    | null: false                    |
| prefecture_id      | integer    | null: false                    |
| days_to_ship_id    | integer    | null: false                    |
| user               | references | null: false,foreign_key: true  |
| introduction       | text       | null: false                    |
| delivery_charge_id | integer    | null: false                    |


### Association

- has_one :purchase_record
- belongs_to : user

## purchase_records テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| product     | references | null: false, foreign_key: true |
| user        | references | null: false, foreign_key: true |

### Association

- belongs_to :product
- belongs_to :destination



## destinations テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| zip_code           | string     | null: false                    |
| prefecture_id      | integer    | null: false                    |
| city               | string     | null: false                    |
| address_1          | string     | null: false                    |
| address_2          | string     |                                |
| phone_number       | string     | null: false                    |
|purchase_record     |references  | null: false                    |


### Association
- belongs_to :purchase_record
