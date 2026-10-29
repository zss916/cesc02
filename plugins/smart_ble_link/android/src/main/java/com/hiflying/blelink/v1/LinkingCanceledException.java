package com.hiflying.blelink.v1;

import com.hiflying.blelink.LinkingError;
import com.hiflying.blelink.LinkingException;

class LinkingCanceledException extends LinkingException {

    public LinkingCanceledException() {
        super(LinkingError.CANCEL);
    }

    public LinkingCanceledException(String detailMessage) {
        super(LinkingError.CANCEL, detailMessage);
    }
}
