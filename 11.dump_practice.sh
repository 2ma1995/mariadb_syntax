# 더프파일생성 : dumpfile.sql이라는 이름의 덤프파일 생성
# how to make db to dump.file
mysqldump -u <db_id> -p <db_name> dumpfile.sql
#  예시
mysqldump -u root -p board > dumpfile.sql
# 한글깨질때
mysqldump -u root -p board -r dumpfile.sql
# 덤프파일 적용(복원)
# <가 특수문자로 인식되어, window에서는 적용이 안될경우, git bash 터미널창을 활용
mysql -u root -p board < dumpfile.sql

#dump파일을 github에 업로드
#리눅스에서 mariadb설치
sudo apt-get install mariadb-server
# mariadb서버 실행
sudo systemctl start mariadb
# mariadb 접속 :1234
sudo mariadb -u root -p
create database board;
# git 다운로드
 sudo apt install git
# git에서 repository clone
git clone 레파지토리주소
#mariadb 덤프파일 복원
sudo mysql -u root -p board < dumpfile.sql