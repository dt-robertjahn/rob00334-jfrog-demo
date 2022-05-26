# To use first
# export JFROG_BASE_URL=https://YOUR_ACCOUNT.jfrog.io/artifactory
# export JFROG_API_KEY=YOUR-API-TOKEN

if [ -z $JFROG_BASE_URL ]; then echo "Missing JFROG_BASE_URL" && exit 1 ; fi
if [ -z $JFROG_API_KEY ]; then echo "Missing JFROG_API_KEY" && exit 1 ; fi

JFROG_REPO=art-helm-charts-dynatrace   # adjust for with your repo name
JFROG_ARTIFACT=demoapp-0.1.0.tgz
JFROG_PROPERTIES="DT_RELEASE_VERSION=0.1|DT_RELEASE_STAGE=staging|DT_RELEASE_PRODUCT=jfrog-demo|DT_RELEASE_BUILD_VERSION=12"

. ../updateHelmChartProperties.sh ${JFROG_BASE_URL} ${JFROG_API_KEY} ${JFROG_REPO} ${JFROG_ARTIFACT} ${JFROG_PROPERTIES} 
