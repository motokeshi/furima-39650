# README

# テーブル設計
## Users Table
|Column             |Type   |Options                    |
|-------------------|-------|---------------------------|
|nickname           |string |null: false                |
|email              |string |null: false, unique: true  |
|encrypted_password |string |null: false                |
|last_name          |string |null: false                |
|last_name_kana     |string |null: false                |
|first_name         |string |null: false                |
|first_name_kana    |string |null: false                |
|birthday           |date   |null: false                |
has_many: Items
has_many: Orders

## Items Table
|Column               |Type       |Options                        |
|---------------------|-----------|-------------------------------|
|name                 |string     |null: false                    |
|description          |text       |null: false                    |
|category_id          |integer    |null: false                    |
|condition_id         |integer    |null: false                    |
|shippin_bear_id      |integer    |null: false                    |
|prefecture_id        |integer    |null: false                    |
|preparation_date_id  |integer    |null: false                    |
|price                |integer    |null: false                    |
|user                 |references |null: false, foreign_key: true |
belongs_to: User
has_one: Order

## Orders Table
|Column |Type       |Options                        |
|-------|-----------|-------------------------------|
|user   |references |null: false, foreign_key: true |
|item   |references |null: false, foreign_key: true |
belongs_to: User
belongs_to: Item
has_one: Address

## Addresses Tabele
|Column         |Type       |Options                        |
|---------------|-----------|-------------------------------|
|postal_code    |string     |null: false                    |
|prefecture_id  |integer    |null: false                    |
|city           |string     |null: false                    |
|address        |string     |null: false                    |
|building_name  |string     |                               |
|phone_number   |string     |null: false                    |
|order          |references |null: false, foreign_key: true |
belongs_to: Order