FROM openjdk:8-jdk

MAINTAINER "Samsul Maarif <samsul@dot-indonesia.com>"

ENV DEBIAN_FRONTEND noninteractive
ENV ANDROID_COMPILE_SDK 27
ENV ANDROID_BUILD_TOOLS 27.0.3
ENV ANDROID_SDK_TOOLS 27.1.0

WORKDIR /sdk

RUN apt-get --quiet update --yes
RUN apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1
RUN wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip android-sdk.zip
RUN mkdir /root/.android/
RUN touch /root/.android/repositories.cfg
RUN echo y | /sdk/tools/bin/sdkmanager --update
RUN echo y | /sdk/tools/bin/sdkmanager --licenses
RUN /sdk/tools/bin/sdkmanager "platform-tools" "platforms;android-26"


RUN wget --quiet --output-document=gradle.zip https://services.gradle.org/distributions/gradle-4.4-bin.zip
RUN unzip gradle.zip

ENV ANDROID_HOME=/sdk/
ENV PATH=$PATH:/sdk/tools/platform-tools/
ENV PATH=$PATH:/sdk/gradle-4.4/bin

RUN gradle --help