-- Scenario to exercise the datacell implementation
-- using a single receptor and emitter
-- The sensor data is simple passed to the actuator.
-- this is the extended version of scenario00

set optimizer='datacell_pipe';

create table datacell.bsktin(
    id integer,
    tag timestamp,
    payload integer
);
create table datacell.bsktout( like datacell.bsktin);

-- initialize the baskets
-- call datacell.prelude(); performs the next two statements
call datacell.basket('datacell.bsktin');
call datacell.basket('datacell.bsktout');

-- initialize receptor
call datacell.receptor('datacell.bsktin','localhost',50501);
call datacell.mode('datacell.bsktin','passive');
call datacell.protocol('datacell.bsktin','udp');
call datacell.resume('datacell.bsktin');

-- externally, activate the sensor leaving some in the basket
--sensor --host=localhost --port=50501 --events=100 --columns=3 --delay=1

-- initialize emitter
call datacell.emitter('datacell.bsktout','localhost',50601);
call datacell.mode('datacell.bsktout','active');
call datacell.protocol('datacell.bsktout','udp');
call datacell.resume('datacell.bsktout');

-- externally, activate the actuator server to listen
-- nc -l -u 50601 

-- compile the continous query
call datacell.query('datacell.pass', 'insert into datacell.bsktout select * from datacell.bsktin;');
call datacell.register('datacell.pass');

-- start the datacell scheduler
call datacell.resume();
call datacell.dump();

-- wrapup
-- stop the datacell scheduler
call datacell.postlude();

-- remove everything
drop table datacell.bsktin;
drop table datacell.bsktout;

