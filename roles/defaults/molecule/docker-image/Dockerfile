FROM geerlingguy/docker-ubuntu2004-ansible as builder
RUN apt update && sudo apt install libpng-dev zlib1g-dev libxml2-dev pkg-config ninja-build cmake git -y
RUN git clone --depth=1 https://github.com/screenplaydev/plutil && cd plutil && git submodule update --init && make install

FROM geerlingguy/docker-ubuntu2004-ansible
COPY --from=builder /usr/lib/libext.so /usr/lib/
COPY --from=builder /usr/lib/libgtest.so /usr/lib/
COPY --from=builder /usr/lib/libgtest_main.so /usr/lib/
COPY --from=builder /usr/lib/libplist.so /usr/lib/
COPY --from=builder /usr/lib/libprocess.so /usr/lib/
COPY --from=builder /usr/lib/libutil.so /usr/lib/
COPY --from=builder /usr/bin/plutil /usr/bin/
COPY --from=builder /usr/bin/PlistBuddy /usr/bin/

RUN apt update && apt install gnustep-base-runtime -y
# Building image with add/copy file by molecule is difficult.
# https://stackoverflow.com/questions/52857499/how-to-customize-molecules-docker-image

# as macOS, preferences are stored under ~/Library/Preferences, instead of GNUstep.
ENV GNUSTEP_USER_ROOT=/root/GNUstep
COPY ./Defaults /root/GNUstep/Defaults
RUN ln -s /usr/bin/true /usr/bin/killall;\
    mkdir -p /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources;\
    ln -s /usr/bin/true /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings

WORKDIR /root
