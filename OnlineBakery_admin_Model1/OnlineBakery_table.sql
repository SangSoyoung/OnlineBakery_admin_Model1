/*** �¶��� ����Ŀ�� *********************/
/*** ȸ�� ���� ���̺� ***/
create table b_member (
    id varchar2(30) primary key,
    pw  varchar2(30),
    name varchar2(30),
    grade number(2)
);
desc b_member;

/* ������ : 1 / VIP : 2 / �Ϲ�ȸ�� : 3 */
insert into b_member values ('aaa', '111', 'ȫ�浿', 1);
insert into b_member values ('bbb', '222', 'Ȳ����', 1);
insert into b_member values ('ccc', '333', '��浿', 3);
commit;

select * from b_member;


/*** ��ǰ ���� ���̺� ***/
create table b_product (
    pcode varchar2(10),
    pname varchar2(30) not null,
    price number(6),
    storage varchar2(30),
    expiration varchar2(30),
    description varchar2(100),
    img varchar2(30),
    constraint pk_code primary key(pcode)
);
desc b_product;

insert into b_product values ('br001', 'Ƽ��̽�', 7000, '���庸��', '���� �� 5��', '�����ؿ�', 'bread_01.jpg');
insert into b_product values('br002', 'ũ����', 2500, '���庸��', '���� �� 5��', 'ũ�����', 'bread_02.jpg');
insert into b_product values('br003', '����佺Ʈ', 3000, '�ǿº���', '���� �� 5��', '�ٻ�ٻ�', 'bread_03.jpg');
insert into b_product values('br004', '���û�', 3800, '�ǿº���', '���� �� 5��', '��������', 'bread_04.jpg');
commit;

select * from b_product;
