# README

## テーブル設計

### usersテーブル

|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false, index: true|
|last_name|string|null:false, index:true|
|support_number|integer||
|company|string||
|position|string||
|profile|text||
|pro|boolean||
|real_name|boolean||
|uid|string|
|provider|string|
|access_token|string|
|image|string|

#### Association
- has_many :picks, through :picks_users
- has_many :picks_users
- has_many :comments
- has_many :keywords

### picksテーブル

|Column|Type|Options|
|------|----|-------|
|url|string|null: false, unique: true|
|image|string|null: false|
|title|string|null: false, index: true|
|body|text|null: false, index: true|
|source|string|null: false|

#### Association
- has_many :comments
- has_many :users, through :picks_users
- has_many :picks_users
- has_many :themes, through :picks_themes
- has_many :picks_themes

### picks_usersテーブル

|Column|Type|Options|
|------|----|-------|
|pick_id|references|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|

#### Association
- belongs_to :pick
- belongs_to :user

### commentsテーブル

|Column|Type|Options|
|------|----|-------|
|comments|text|index: true|
|pick_id|references|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|

#### Association
- belongs_to :pick
- belongs_to :user

### likesテーブル

|Column|Type|Options|
|------|----|-------|
|comment_id|references|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|

#### Association
- belongs_to :comment
- belongs_to :user

### keywordsテーブル

|Column|Type|Options|
|------|----|-------|
|keyword|string|null:false|
|user_id|references|null: false, foreign_key: true|

#### Association
- belongs_to :user


### themesテーブル

|Column|Type|Options|
|------|----|-------|
|theme|string|null: false|

#### Association
- has_many :picks, through :picks_themes
- has_many :picks_themes

### picks_themesテーブル

|Column|Type|Options|
|------|----|-------|
|pick_id|references|null: false, foreign_key: true|
|theme_id|references|null: false, foreign_key: true|

#### Association
- belongs_to :pick
- belongs_to :theme
