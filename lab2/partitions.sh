parted --script /dev/md0 \
        mktable gpt \
        mkpart P1 0% 20% \
        mkpart P2 20% 40% \
        mkpart P3 40% 60% \
        mkpart P4 60% 80% \
        mkpart P5 80% 100%