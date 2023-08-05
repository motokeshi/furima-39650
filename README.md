# README

# テーブル設計
## Users Table
|Column             |Type   |Options      |
|-------------------|-------|-------------|
|nickname           |string |null: false  |
|email              |string |null: false  |
|encrypted_password |string |null: false  |
|last_name          |string |null: false  |
|last_name_kana     |string |null: false  |
|first_name         |string |null: false  |
|first_name_kana    |string |null: false  |
|birthday           |date   |null: false  |

## Items Table
|Column           |Type       |Options                        |
|-----------------|-----------|-------------------------------|
|name             |string     |null: false                    |
|description      |text       |null: false                    |
|condition        |string     |null: false                    |
|shippin_bear     |string     |null: false                    |
|shipping_region  |string     |null: false                    |
|preparation_date |string     |null: false                    |
|price            |integer    |null: false                    |
|user_id          |references |null: false, foreign_key: true |

## Orders Table
|Column         |Type       |Options                        |
|---------------|-----------|-------------------------------|
|postal_code    |string     |null: false                    |
|prefecture     |string     |null: false                    |
|city           |string     |null: false                    |
|address        |string     |null: false                    |
|building_name  |string     |                               |
|user_id        |references |null: false, foreign_key: true |
|item_id        |references |null: false, foreign_key: true |