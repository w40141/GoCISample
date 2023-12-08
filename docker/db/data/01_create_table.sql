START TRANSACTION;

-- --------------------------------------------------------
--
-- テーブルの構造 `user`
--
CREATE TABLE
  IF NOT EXISTS `user` (
    `id` VARCHAR(26) PRIMARY KEY NOT NULL,
    `name` varchar(30) NOT NULL
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin;

-- --------------------------------------------------------
--
-- テーブルの構造 `todo`
--
CREATE TABLE
  IF NOT EXISTS `todo` (
    `id` VARCHAR(26) PRIMARY KEY NOT NULL,
    `title` varchar(200) NOT NULL,
    `status` int NOT NULL DEFAULT 0,
    `user_id` VARCHAR(26) NOT NULL,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY fk_todo_in_user_id (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin;

COMMIT;
