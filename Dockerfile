FROM openjdk:8-jdk

MAINTAINER "Samsul Maarif <samsul@dot-indonesia.com>"

ENV DEBIAN_FRONTEND noninteractive
#ENV ANDROID_COMPILE_SDK 27
#ENV ANDROID_BUILD_TOOLS 27.0.3
#ENV ANDROID_SDK_TOOLS 27.1.0
ENV ANDROID_HOME=/sdk/

WORKDIR /sdk

RUN apt-get --quiet update --yes
RUN apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip android-sdk.zip \
    && rm -rf android-sdk.zip
RUN mkdir /root/.android/
RUN touch /root/.android/repositories.cfg
RUN echo y | /sdk/tools/bin/sdkmanager --update
#RUN echo y | /sdk/tools/bin/sdkmanager --licenses
RUN echo y | /sdk/tools/bin/sdkmanager "platform-tools" 
RUN echo y | /sdk/tools/bin/sdkmanager "platforms;android-26"
RUN echo y | /sdk/tools/bin/sdkmanager "build-tools;27.0.3"

RUN mkdir -p $ANDROID_HOME/licenses/ \
  && echo "8933bad161af4178b1185d1a37fbf41ea5269c55\nd56f5187479451eabf01fb78af6dfcb131a6481e" > $ANDROID_HOME/licenses/android-sdk-license \
  && echo "84831b9409646a918e30573bab4c9c91346d8abd" > $ANDROID_HOME/licenses/android-sdk-preview-license

RUN wget --quiet --output-document=gradle.zip https://services.gradle.org/distributions/gradle-4.4-bin.zip
RUN unzip gradle.zip \
    && rm -rf gradle.zip

ENV PATH=$PATH:/sdk/tools/platform-tools/:/sdk/gradle-4.4/bin:/sdk/tools/bin

RUN gradle --help