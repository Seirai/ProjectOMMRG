//Some Trig Functions

proc/tan(theta) return sin(theta) / cos(theta)
proc/cot(theta) return cos(theta) / sin(theta)
proc/sec(theta) return 1 / cos(theta)
proc/csc(theta) return 1 / sin(theta)
proc/atan(x) return arccos(1 / sqrt(1+x*x))
proc/acot(x) return arcsin(1 / sqrt(1+x*x))
proc/asec(x) return arccos(1 / x)
proc/acsc(x) return arcsin(1 / x)
proc{
    arctan2(dy, dx)
        if(dy == 0)
            if(dx > 0)
                return 0
            else if(dx == 0)
                return 0
            else
                return 180
        if(dx == 0)
            if(dy > 0)
                return 90
            else if(dy == 0)
                return 0
            else
                return -90
        else
            var/angle = atan(dy/dx)
            if(dx < 0)
                angle = 180 - angle
            if(dy < 0)
                angle = -angle
            return angle
}
