--SET search_path = json_test;
DO $$
DECLARE 
  _player1_id VARCHAR;
BEGIN
  SELECT /*MAX(*/ CAST( replay_data->'entityConfigs' AS VARCHAR ) /*)*/
    INTO _player1_id
  FROM replays;

  RAISE NOTICE '%', _player1_id;
END$$;
