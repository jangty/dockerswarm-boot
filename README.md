# 정보 임의 수정금지 
포트나 이름 수정필요시 TA 연락주세요

# 이미지 빌드, run 
어플리케이션 jar, scouter 포함되어있는 이미지를 생성하고, docker swarm환경에서 기동한다

docker swarm 환경에서 수동으로 기동하지 않고, 젠킨스에서 관리한다.



## 사용시 관리해야하는 정보
어플리케이션별로 아래 정보 관리필요
1. docker-stack.yml
*  이미지 이름
*  was, ajp, manager 포트
*  로그 위치

2. scouter/scouter.conf
* 스카우터 등록할 이름 : obj_name
* 스카우터 수집서버 IP : 
* 스카우터 수집서버 포트 : 

