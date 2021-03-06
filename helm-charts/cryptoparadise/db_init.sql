DELIMITER $
BEGIN NOT ATOMIC

If not exists (SELECT 1 FROM   INFORMATION_SCHEMA.SCHEMATA WHERE  SCHEMA_NAME = 'bot_manager')
then
  CREATE DATABASE bot_manager;
  grant all privileges on bot_manager.* to 'test'@'%';
end if;
END $
DELIMITER ;

DELIMITER $
BEGIN NOT ATOMIC

If not exists (SELECT 1 
               FROM   INFORMATION_SCHEMA.SCHEMATA
               WHERE  SCHEMA_NAME = 'candle_data_service')
then
  CREATE DATABASE candle_data_service;
  grant all privileges on candle_data_service.* to 'test'@'%';
end if;
END $
DELIMITER ;


DELIMITER $
BEGIN NOT ATOMIC

If not exists (SELECT 1 
               FROM   INFORMATION_SCHEMA.SCHEMATA
               WHERE  SCHEMA_NAME = 'transaction_service')
then
  CREATE DATABASE transaction_service;
  grant all privileges on transaction_service.* to 'test'@'%';
end if;
END $
DELIMITER ;

DELIMITER $
BEGIN NOT ATOMIC

If not exists (SELECT 1 
               FROM   INFORMATION_SCHEMA.SCHEMATA
               WHERE  SCHEMA_NAME = 'stock_mock')
then
  CREATE DATABASE stock_mock;
  grant all privileges on stock_mock.* to 'test'@'%';
end if;
END $
DELIMITER ;