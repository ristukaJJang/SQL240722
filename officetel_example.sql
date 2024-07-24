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
from board where title like '%%'
order by receipt_number desc 
limit 0, 10;

-- 게시물 작성
insert into board (title, contents, writer_id) 
values ('열두번째 게시글', '안녕하세요', 'qwer1234');

-- 게시물 상세보기
update board set view_count = view_count + 1
where receipt_number = 1;

select receipt_number, title, writer_id, write_date, view_count, contents, reply
from board where receipt_number = 1;

-- 답글 작성
update board set reply = '반갑습니다.', status = true
where receipt_number = 1;

-- 게시물 수정
update board set title = '게시물 수정', contents = '집 가고 싶어요'
where receipt_number = 1;

-- 게시물 삭제
delete from board where receipt_number = 1;