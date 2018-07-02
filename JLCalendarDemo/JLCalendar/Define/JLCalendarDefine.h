//
//  JLCalendarDefine.h
//  JLCalendarDemo
//
//  Created by Chang Li on 2018/6/28.
//  Copyright © 2018年 pwnlc. All rights reserved.
//

#ifndef JLCalendarDefine_h
#define JLCalendarDefine_h

#define JLWeakObj(obj) __weak typeof(obj) obj##Weak = obj

#define JLScreenWidth [UIScreen mainScreen].bounds.size.width
#define JLScreenHeight [UIScreen mainScreen].bounds.size.height

#define JLRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define JLColorWithHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

#define WeakObj(obj) __weak typeof(obj) obj##Weak = obj

// CollectionView Header 月份标题属性
#define JLCalendarMonthTitleWidth 50
#define JLCalendarMonthTitleHeight 36
#define JLCalendarMonthTitleFontSize 12
#define JLCalendarMonthTitleFontColor JLColorWithHex(0x999999)
#define JLCalendarMonthTitleBackgroundColor JLColorWithHex(0xffffff)

// CollectionView Cell 属性



#endif /* JLCalendarDefine_h */
