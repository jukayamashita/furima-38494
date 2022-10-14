
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

| Column             | Type       | Options                |
| ------------------ | ---------- | ---------------------- |
| title              | string     | null: false            |
| category           | string     | null: false            |
| condition          | string     | null: false            |
| price              | string     | null: false            |
| shipping           | string     | null: false            |
| introduce          | text       | null: false            |
| user_id            | references | null: false            |


### Association

- has_one :purchase_record
- belongs_to : user
- has_one :destination


## purchase_records テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| product_id  | references | null: false, foreign_key: true |
| user_id     | references | null: false, foreign_key: true |

### Association

- belongs_to :product

## destinations テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| zip_code           | string     | null: false,                   |
| prefecture         | string     | null: false                    |
| city               | string     | null: false                    |
| address_1          | text       | null: false                    |
| address_2          | text       | null: false                    |
| phone_number       | string     | null: false                    |
| user_id            | references | null: false, foreign_key: true |

### Association
- belongs_to :product