//
//  hookMgr.m
//  基本防护
//
//  Created by zhihuishequ on 2018/5/28.
//  Copyright © 2018年 WinJayQ. All rights reserved.
//

#import "hookMgr.h"
#import "fishhook.h"
#import <objc/message.h>
#include <objc/runtime.h>
@interface NSObject(Hookt)
@end

@implementation NSObject(Hookt)

+(void) load {
    
     static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            NSLog(@"hookMgr--Load");
               //内部用到的交换代码
               
//               Method old = class_getInstanceMethod(objc_getClass("ViewController"), @selector(btnClick1:));
//               Method new = class_getInstanceMethod(self, @selector(click1Hook:));
//               method_exchangeImplementations(old, new);
               
               
               //动态Hook方法2
               
               SEL origSel_ = sel_getUid("btnClick1:");
               SEL swizzileSel = sel_getUid("click1Hook2:");
               Method origMethod = class_getInstanceMethod(objc_getClass("ViewController"), origSel_);
               const char* type = method_getTypeEncoding(origMethod);
               class_addMethod(objc_getClass("ViewController"), swizzileSel, (IMP)click1Hook2, type);
               Method swizzleMethod = class_getInstanceMethod(objc_getClass("ViewController"), swizzileSel);
               method_exchangeImplementations(origMethod, swizzleMethod);
               
              
               //在交换代码之前，把所有的runtime代码写完 
               
               //基本防护
               struct rebinding bd;
               bd.name = "method_exchangeImplementations";
               bd.replacement=myExchang;
               bd.replaced=(void *)&exchangeP;
               
               struct rebinding rebindings[]={bd};
               rebind_symbols(rebindings, 1);
        });
    }

    //保留原来的交换函数
    void (* exchangeP)(Method _Nonnull m1, Method _Nonnull m2);

    //新的函数
    void myExchang(Method _Nonnull m1, Method _Nonnull m2){
        NSLog(@"检测到了hook");
    }

    static void click1Hook2(id obj,SEL sel, id sender) {
        NSLog(@"原来APP的hook保留");
        //调用原来的方法
         SEL swizzileSel = sel_getUid("click1Hook2:");
        ((void (*)(id,SEL,id)) objc_msgSend)(obj,swizzileSel,sender);
        
    }
    -(void)click1Hook:(id)sender{
        NSLog(@"原来APP的hook保留");
         SEL swizzileSel = sel_getUid("click1Hook:");
        ((void (*)(id, SEL, id))objc_msgSend)(self, swizzileSel, sender);
    }

@end

@implementation hookMgr

////专门HOOK
//+(void)load{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        NSLog(@"hookMgr--Load");
//           //内部用到的交换代码
//           
//           Method old = class_getInstanceMethod(objc_getClass("ViewController"), @selector(btnClick1:));
//           Method new = class_getInstanceMethod(self, @selector(click1Hook:));
//           method_exchangeImplementations(old, new);
//           
//           /*
//           //动态Hook方法2
//           
//           SEL origSel_ = sel_getUid("btnClick1:");
//           SEL swizzileSel = sel_getUid("click1Hook2:");
//           Method origMethod = class_getInstanceMethod(objc_getClass("ViewController"), origSel_);
//           const char* type = method_getTypeEncoding(origMethod);
//           class_addMethod(objc_getClass("ViewController"), swizzileSel, (IMP)click1Hook2, type);
//           Method swizzleMethod = class_getInstanceMethod(objc_getClass("ViewController"), swizzileSel);
//           method_exchangeImplementations(origMethod, swizzleMethod);*/
//           
//          
//           //在交换代码之前，把所有的runtime代码写完 
//           
//           //基本防护
//           struct rebinding bd;
//           bd.name = "method_exchangeImplementations";
//           bd.replacement=myExchang;
//           bd.replaced=(void *)&exchangeP;
//           
//           struct rebinding rebindings[]={bd};
//           rebind_symbols(rebindings, 1);
//    });
//}
//
////保留原来的交换函数
//void (* exchangeP)(Method _Nonnull m1, Method _Nonnull m2);
//
////新的函数
//void myExchang(Method _Nonnull m1, Method _Nonnull m2){
//    NSLog(@"检测到了hook");
//}
//
//static void click1Hook2(id obj,SEL sel, id sender) {
//    NSLog(@"原来APP的hook保留");
//    //调用原来的方法
//     SEL swizzileSel = sel_getUid("click1Hook2:");
//    ((void (*)(id,SEL,id)) objc_msgSend)(obj,swizzileSel,sender);
//    
//}
//-(void)click1Hook:(id)sender{
//    NSLog(@"原来APP的hook保留");
//     SEL swizzileSel = sel_getUid("click1Hook:");
//    ((void (*)(id, SEL, id))objc_msgSend)([hookMgr new], swizzileSel, sender);
//}
@end






















