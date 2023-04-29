# aluball

White LED lamp made with aluminium PCBs

| <img src="img/lamp.jpg" width="512">   | <img src="img/multiple.jpg" width="512"> |
|-|-|
| <img src="img/single.jpg" width="512"> | <img src="img/warm.jpg" width="512">     |
| <img src="img/dihedral.jpg" width="513"> |<img src="img/driver.jpg" width="513">  |
| <img src="img/facet.jpg" width="513"> | |

# software

https://github.com/brainsmoke/esp32leddriver

## ESP32

https://github.com/brainsmoke/esp32leddriver/tree/master/firmware/esp32


Edit `fs/conf/model.json:`

```
{
	"model": "/models/aluball"
}
```

## STM32

https://github.com/brainsmoke/esp32leddriver/blob/master/firmware/stm32/m02812/src/uartball16.bin

## PADAUK

https://github.com/brainsmoke/esp32leddriver/tree/master/firmware/pdk/softpwm

`./write.sh <address>` 3x for each in 0..7

Use the mapping in https://github.com/brainsmoke/aluball/blob/main/map.svg

