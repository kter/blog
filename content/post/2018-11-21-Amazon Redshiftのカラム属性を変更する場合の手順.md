---
author: kter
categories:
- AWS
date: "2018-11-21T12:00:00Z"
id: 607
image: null
tags:
- AWS
- Redshift
title: Amazon Redshiftのカラム属性を変更する場合の手順
---
Redshiftでカラムの属性を変更する場合、一旦別名で変更後の属性でカラムを作った後、リネームして既存カラムと置き換える必要があります。

下記の例ではtable_nameというテーブルに対して、column_nameというカラムのデフォルト値を変更していますが、デフォルト値以外の変更も基本同じような対応で可能です。

##### column_name_tmpというカラム名で新しいカラムデフォルト値を設定する。

```sql
ALTER TABLE table_name ADD COLUMN column_name_tmp VARCHAR(20) DEFAULT 'new_default_value';
```

##### 既存カラム (column_name) の値を先ほど作成したcolumn_name_tmpにコピーする。

```sql
UPDATE table_name SET column_name_tmp = column_name;
```

##### 既存カラムを削除する。

```sql
ALTER TABLE table_name DROP COLUMN column_name CASCADE;
```

##### 新しく作成したカラムを既存カラム名にリネームする。

```sql
ALTER TABLE table_name RENAME COLUMN column_name_tmp TO column_name;
```

##### 旧のデフォルト値で入っていたデータの更新

```sql
UPDATE table_name SET column_name = 'new_default_value' WHERE column_name = 'old_default_value';
```

##### 権限がリセットされてしまった場合はつけ直す

```sql
-- user_nameに対してtable_nameテーブルの全操作を許可
grant all privileges on table_name TO user_name;
-- 確認
\z
```

