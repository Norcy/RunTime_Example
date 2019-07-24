[Github_参考](https://github.com/strivever/Array-Dictionary-safeTool/blob/master/ST_SafeTool/NSObject%2BImpChangeTool.m)


swizzleMethod 采用 C 函数，而不是 NSObject 的方法，是为了防止子类在 load 方法中向其自己发送消息，那样会导致其 +initialize 方法在 load 的时候被提前调用，而此时系统环境是不稳定的
