-- 데이터베이스 생성
create database officetel;
use officetel;

-- 이메일 인증 테이블 생성
create table email_auth(
	email varchar(100) primary key check(email regexp '^[a-zA-Z0-9]*@([-.]?[a-zA-Z0-9])*\.[a-zA-Z]{2,4}$'),
    auth_number varchar(4) not null check(auth_number REGEXP '^[0-9]{4}$')
);

-- 회원 테이블 생성
create table user(
	id varchar(20) primary key not null unique,
    password varchar(255) not null,
    email varchar(100) not null unique,
    join_path varchar(5) not null default 'HOME',
    role varchar(6) not null default 'NORMAL',
    constraint user_email_fk foreign key (email) references email_auth(email)
);

-- 게시물 테이블 생성
create table board(
	receipt_number int not null unique primary key auto_increment,
    title varchar(50) not null,
    status boolean not null default false,
    writer_id varchar(20) not null,
    write_date datetime not null default now(),
    view_count int not null default 0,
    contents varchar(1000) not null,
    reply text,
    constraint writer_fk foreign key (writer_id) references user(id)
);

-- 로그인
-- select * from user where id = :id and password = :password;
select * from user where id = 'qwer1234'; -- 비밀번호는 암호화되기 때문에 아이디만 비교함

-- 아이디 중복 확인, 존재하면 사용 불가, 없으면 사용 가능
select * from user where id = 'qwer1234';

-- 이메일 인증, 존재하면 사용 불가, 없으면 사용 가능
insert into email_auth values ('qwer1234@qwer.com', '0123');

-- 이메일 인증 확인
select * from email_auth where email = 'qwer1234@qwer.com' and auth_number = '0123';

-- 회원가입
insert into user(id, password, email) values ('qwer1234', 'qwer1234', 'qwer1234@qwer.com');

-- 게시물 리스트
select receipt_number, status, title, writer_id, write_date, view_count 
from board where title like '%:title%'
order by receipt_number desc limit 10;