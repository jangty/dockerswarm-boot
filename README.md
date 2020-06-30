# 정보 임의 수정금지 
포트나 이름 수정필요시 TA 연락주세요

# 이미지 빌드, run 
어플리케이션 jar, scouter 포함되어있는 이미지를 생성하고, docker swarm환경에서 기동한다

docker swarm 환경에서 수동으로 기동하지 않고, 

젠킨스에서 stack_deploy_jenkins.sh 스크립트로 배포 (수동으로 배포가 필요한 경우는 stack_deploy_manual.sh 사용. 사용법 어려움.)

develop 브랜치 : 개발서버용 env, master 브랜치 운영서버용 env


## 사용시 관리해야하는 정보
어플리케이션별로 아래 정보 관리필요
1. .env 파일

- 어플리케이션 이름 (WAS이름) : APPLICATION_NAME
- 도커 레지스트리 정보 : REGISTRY
- http 포트 : 
- ajp 포트 : 
- admin 포트 : 

2. entrypoint.sh
- 스카우터 수집서버 IP
- 스카우터 수집서버 Port

## 젠킨스 pipeline 
deploy, rollback 용 2개를 만들어줘야 한다


