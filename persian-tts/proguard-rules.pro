
#-assumenosideeffects class android.util.Log {
#    public static boolean isLoggable(java.lang.String, int);
#    public static *** v(...);
#    public static *** i(...);
#    public static *** w(...);
#    public static *** d(...);
#    public static *** e(...);
#}
#-assumenosideeffects class java.io.PrintStream {
#    public void println(...);
#    public void print(...);
#}
#-assumenosideeffects class java.lang.Throwable {
#    public void printStackTrace(...);
#}








-dontwarn java.lang.invoke.StringConcatFactory






-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable
-keep public class * extends java.lang.Exception
-keep class com.crashlytics.** { *; }
-dontwarn com.crashlytics.**





-keepattributes *Annotation*
-keepclassmembers class * {
    @org.greenrobot.eventbus.Subscribe <methods>;
}
-keep enum org.greenrobot.eventbus.ThreadMode { *; }
-keepclassmembers class * extends org.greenrobot.eventbus.util.ThrowableFailureEvent {
    <init>(java.lang.Throwable);
}






-keep class ir.am3n.craptionreporter.** { *; }







-keep class com.smartpek.utilize.sweetalert.** { *; }






-keep class com.daimajia.easing.** { *; }






-keep class com.amitshekhar.DebugDB**
-keep class com.amitshekhar.model.** { *; }






# for Screenshot.kt
-keepclassmembers class rx.internal.util.unsafe.** {
    long producerIndex;
    long consumerIndex;
}
-keep class rx.internal.util.unsafe.** { *; }
-keep class rx.schedulers.Schedulers {
    public static <methods>;
}
-keep class rx.schedulers.ImmediateScheduler {
    public <methods>;
}
-keep class rx.schedulers.TestScheduler {
    public <methods>;
}
-keep class rx.schedulers.Schedulers {
    public static ** test();
}





-dontwarn junit.awtui.**
-dontwarn junit.swingui.**
-dontwarn android.test.**
-dontwarn com.google.android.gms.auth.**
-dontwarn junit.runner.**




-keep class org.osmdroid.** { *; }
-dontwarn org.osmdroid.**

-keep class org.neshan.** {*;}

-keep class com.google.android.gms.location.** { *; }


-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**





-dontwarn okio.**
-dontwarn okhttp3.internal.platform.*
-dontwarn okhttp3.internal.platform.**
-keep class okhttp3.** { *; }
-keep interface okhttp3.** { *; }
-dontwarn com.squareup.okhttp3.**
-keep class com.squareup.okhttp3.** { *; }
-keep interface com.squareup.okhttp3.** { *; }
-dontwarn javax.annotation.Nullable
-dontwarn javax.annotation.ParametersAreNonnullByDefault
-keepnames class okhttp3.internal.publicsuffix.PublicSuffixDatabase
-dontwarn okhttp3.**
-dontwarn org.conscrypt.**







-keepclassmembers,allowobfuscation class * {
  @com.google.gson.annotations.SerializedName <fields>;
}





-keepattributes Signature, InnerClasses
-keepattributes *Annotation*, InnerClasses
-dontnote kotlinx.serialization.SerializationKt
-keepclassmembers,allowshrinking,allowobfuscation interface * {
    @retrofit2.http.* <methods>;
}
-dontwarn org.codehaus.mojo.animal_sniffer.IgnoreJRERequirement
-dontwarn javax.annotation.**
-dontwarn kotlin.Unit
-dontwarn retrofit2.-KotlinExtensions





# SimpleXML
-keep interface org.simpleframework.xml.core.Label {
   public *;
}
-keep class * implements org.simpleframework.xml.core.Label {
   public *;
}
-keep interface org.simpleframework.xml.core.Parameter {
   public *;
}
-keep class * implements org.simpleframework.xml.core.Parameter {
   public *;
}
-keep interface org.simpleframework.xml.core.Extractor {
   public *;
}
-keep class * implements org.simpleframework.xml.core.Extractor {
   public *;
}





#-keep class com.saco.hamsi.MsvAuthority
#-keepclassmembers class com.saco.hamsi.MsvAuthority.** { *; }
#-keep class com.saco.simorghattar.MsvAuthority
#-keepclassmembers class com.saco.simorghattar.MsvAuthority.** { *; }





-keep class com.amirhosein.loadingview.** { *; }
-keep class com.amirhosein.loadingview.Indicators.** { *; }




-keep class com.shockwave.**






-keepclassmembers enum * { *; }




-keepattributes Signature

# For using GSON @Expose annotation
-keepattributes *Annotation*

# Gson specific classes
-dontwarn sun.misc.**
#-keep class com.google.gson.stream.** { *; }

# Application classes that will be serialized/deserialized over Gson
-keep class com.google.gson.examples.android.model.** { <fields>; }

# Prevent proguard from stripping interface information from TypeAdapter, TypeAdapterFactory,
# JsonSerializer, JsonDeserializer instances (so they can be used in @JsonAdapter)
-keep class * extends com.google.gson.TypeAdapter
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# Prevent R8 from leaving Data object members always null
-keepclassmembers,allowobfuscation class * {
  @com.google.gson.annotations.SerializedName <fields>;
}

-keep class com.google.gson.examples.android.model.** { *; }
-keep class com.google.gson.** { *; }
-keep class com.google.maps.model.LatLng.** { *; }
-keep class com.google.maps.** { *; }
-keep class com.google.android.gms.maps.** { *; }
-keep interface com.google.android.gms.maps.** { *; }
-keepnames class com.google.android.maps.** {*;}
-keep public class com.google.android.maps.** {*;}





-keep class com.google.appengine.GaeRequestHandler.**  { *; }
-keep class com.google.appengine.api.urlfetch.URLFetchServiceFactory.** { *; }
-dontwarn com.google.appengine.**






-keep class org.joda.time.** {*;}
-keep class org.joda.** { *; }
-dontwarn org.joda.time.**
-dontwarn org.joda.convert.**






-keep public class * implements com.bumptech.glide.module.GlideModule
-keep public class * extends com.bumptech.glide.module.AppGlideModule
-keep public enum com.bumptech.glide.load.ImageHeaderParser$** {
  **[] $VALUES;
  public *;
}






-keepclasseswithmembernames class * {
    native <methods>;
}
-keep class android.support.v8.renderscript.** { *; }
-dontwarn carbon.BR
-dontwarn carbon.internal**
-dontwarn java.lang.invoke**
-dontwarn android.databinding.**
-keep class android.databinding.** { *; }








-keep class android.newland.** { *; }
-keep public class android.newland.*
-keep public class android.newland.**
-keep public class android.newland.** {
  public protected *;
}

-keep class com.newland.** { *; }
-keep class com.newland.me.** { *; }
-keep public class com.newland.*
-keep public class com.newland.**
-keep public class com.newland.** {
  public protected *;
}
-keep public class com.newland.me.*
-keep public class com.newland.me.**
-keep public class com.newland.me.** {
  public protected *;
}

-keep public class ir.dariacard.pos.device.*
-keep public class ir.dariacard.pos.device.**
-keep public class ir.dariacard.pos.device.** {
  public protected *;
}










#ACRA specifics
# Restore some Source file names and restore approximate line numbers in the stack traces,
# otherwise the stack traces are pretty useless
-keepattributes SourceFile,LineNumberTable
# ACRA needs "annotations" so add this...
# Note: This may already be defined in the default "proguard-android-optimize.txt"
# file in the SDK. If it is, then you don't need to duplicate it. See your
# "project.properties" file to get the path to the default "proguard-android-optimize.txt".
-keepattributes *Annotation*
# ACRA loads Plugins using reflection, so we need to keep all Plugin classes
-keep class * implements org.acra.plugins.Plugin {*;}
# ACRA uses enum fields in annotations, so we have to keep those
-keep enum org.acra.** {*;}
-dontwarn android.support.**






-keep class org.openudid.** { *; }
-keep class ly.count.android.sdk.** { *; }







-keep class android.support.v8.renderscript.** { *; }
-keep class androidx.renderscript.** { *; }








-keep class com.wang.avi.** { *; }
-keep class com.wang.avi.indicators.** { *; }







-keep class com.pax.** { *; }










-keepattributes *Annotation*
-keepclassmembers class * {
    @org.greenrobot.eventbus.Subscribe <methods>;
}
-keep enum org.greenrobot.eventbus.ThreadMode { *; }
 
# And if you use AsyncExecutor:
-keepclassmembers class * extends org.greenrobot.eventbus.util.ThrowableFailureEvent {
    <init>(java.lang.Throwable);
}
















##---------------Begin: proguard configuration for Gson  ----------
# Gson uses generic type information stored in a class file when working with fields. Proguard
# removes such information by default, so configure it to keep all of it.
-keepattributes Signature

# For using GSON @Expose annotation
-keepattributes *Annotation*

# Gson specific classes
-keep class sun.misc.Unsafe { *; }
#-keep class com.google.gson.stream.** { *; }

# Application classes that will be serialized/deserialized over Gson
-keep class com.google.gson.examples.android.model.** { *; }

##---------------End: proguard configuration for Gson  ----------















-dontwarn com.jeremyliao.liveeventbus.**
-keep class com.jeremyliao.liveeventbus.** { *; }
-keep class androidx.lifecycle.** { *; }
-keep class androidx.arch.core.** { *; }














# JSR 305 annotations are for embedding nullability information.
-dontwarn javax.annotation.**

-keepclasseswithmembers class * {
    @com.squareup.moshi.* <methods>;
}

-keep @com.squareup.moshi.JsonQualifier @interface *

# Enum field names are used by the integrated EnumJsonAdapter.
# values() is synthesized by the Kotlin compiler and is used by EnumJsonAdapter indirectly
# Annotate enums with @JsonClass(generateAdapter = false) to use them with Moshi.
-keepclassmembers @com.squareup.moshi.JsonClass class * extends java.lang.Enum {
    <fields>;
    **[] values();
}

# Keep helper method to avoid R8 optimisation that would keep all Kotlin Metadata when unwanted
-keepclassmembers class com.squareup.moshi.internal.Util {
    private static java.lang.String getKotlinMetadataClassName();
}

# Keep ToJson/FromJson-annotated methods
-keepclassmembers class * {
  @com.squareup.moshi.FromJson <methods>;
  @com.squareup.moshi.ToJson <methods>;
}

-keep @com.squareup.moshi.JsonQualifier interface *

-keepclassmembers class com.squareup.moshi.internal.Util {
    private static java.lang.String getKotlinMetadataClassName();
}

-keep,allowobfuscation,allowshrinking class kotlin.coroutines.Continuation













-keep class org.pytorch.** { *; }
-keep class com.facebook.jni.** { *; }











-keep public interface com.google.mediapipe.framework.* {
  public *;
}

# This method is invoked by native code.
-keep public class com.google.mediapipe.framework.Packet {
  public static *** create(***);
  public long getNativeHandle();
  public void release();
}

# This method is invoked by native code.
-keep public class com.google.mediapipe.framework.PacketCreator {
  *** releaseWithSyncToken(...);
}

# This method is invoked by native code.
-keep public class com.google.mediapipe.framework.MediaPipeException {
  <init>(int, byte[]);
}

# Required to use PacketCreator#createProto
-keep class com.google.mediapipe.framework.ProtoUtil$SerializedMessage { *; }

-keep class com.google.mediapipe.solutioncore.** {*;}
-keep class com.google.protobuf.** {*;}
-keepclassmembers class * extends com.google.protobuf.GeneratedMessageLite { *; }

-dontwarn javax.lang.model.SourceVersion
-dontwarn javax.lang.model.element.Element
-dontwarn javax.lang.model.element.ElementKind
-dontwarn javax.lang.model.type.TypeMirror
-dontwarn javax.lang.model.type.TypeVisitor
-dontwarn javax.lang.model.util.SimpleTypeVisitor8









-dontwarn java.lang.management.BufferPoolMXBean
-dontwarn javax.management.MalformedObjectNameException
-dontwarn javax.management.ObjectName
-dontwarn org.osgi.annotation.versioning.ConsumerType
-dontwarn org.slf4j.Logger
-dontwarn org.slf4j.LoggerFactory












# JavaCV
-keep @org.bytedeco.javacpp.annotation interface * {
    *;
}

-keep @org.bytedeco.javacpp.annotation.Platform public class *

-keepclasseswithmembernames class * {
    @org.bytedeco.* <fields>;
}

-keepclasseswithmembernames class * {
    @org.bytedeco.* <methods>;
}

-keepattributes EnclosingMethod
-keep @interface org.bytedeco.javacpp.annotation.*,javax.inject.*

-keepattributes *Annotation*, Exceptions, Signature, Deprecated, SourceFile, SourceDir, LineNumberTable, LocalVariableTable, LocalVariableTypeTable, Synthetic, EnclosingMethod, RuntimeVisibleAnnotations, RuntimeInvisibleAnnotations, RuntimeVisibleParameterAnnotations, RuntimeInvisibleParameterAnnotations, AnnotationDefault, InnerClasses
-keep class org.bytedeco.javacpp.** {*;}
-dontwarn java.awt.**
-dontwarn org.bytedeco.javacv.**
-dontwarn org.bytedeco.javacpp.**

# end javacv

-keep class org.bytedeco.** { *; }
-keep class org.bytedeco.ffmpeg.presets.** { *; }
-keep class org.bytedeco.ffmpeg.avutil.** { *; }
-keep class org.bytedeco.ffmpeg.avformat.** { *; }
-keep class org.bytedeco.ffmpeg.avcodec.** { *; }
-keep class org.bytedeco.ffmpeg.swresample.** { *; }
-keep class org.bytedeco.ffmpeg.avfilter.** { *; }
-keep class org.bytedeco.ffmpeg.swscale.** { *; }
-keep class org.bytedeco.ffmpeg.avdevice.** { *; }
-keep class org.bytedeco.ffmpeg.postproc.** { *; }

-dontwarn org.bytedeco.cpython.global.python
-dontwarn org.bytedeco.numpy.global.numpy

















-dontwarn java.lang.instrument.ClassFileTransformer
-dontwarn java.lang.instrument.Instrumentation
-dontwarn javax.tools.JavaCompiler
-dontwarn javax.tools.ToolProvider
-dontwarn net.bytebuddy.ByteBuddy
-dontwarn net.bytebuddy.ClassFileVersion
-dontwarn net.bytebuddy.TypeCache$SimpleKey
-dontwarn net.bytebuddy.TypeCache$Sort
-dontwarn net.bytebuddy.TypeCache$WithInlineExpunction
-dontwarn net.bytebuddy.TypeCache
-dontwarn net.bytebuddy.agent.ByteBuddyAgent
-dontwarn net.bytebuddy.asm.Advice$AllArguments
-dontwarn net.bytebuddy.asm.Advice$Argument
-dontwarn net.bytebuddy.asm.Advice$Enter
-dontwarn net.bytebuddy.asm.Advice$OnMethodEnter
-dontwarn net.bytebuddy.asm.Advice$OnMethodExit
-dontwarn net.bytebuddy.asm.Advice$OnNonDefaultValue
-dontwarn net.bytebuddy.asm.Advice$Origin
-dontwarn net.bytebuddy.asm.Advice$Return
-dontwarn net.bytebuddy.asm.Advice$This
-dontwarn net.bytebuddy.asm.Advice$WithCustomMapping
-dontwarn net.bytebuddy.asm.Advice
-dontwarn net.bytebuddy.asm.AsmVisitorWrapper$AbstractBase
-dontwarn net.bytebuddy.asm.AsmVisitorWrapper$ForDeclaredMethods$MethodVisitorWrapper
-dontwarn net.bytebuddy.asm.AsmVisitorWrapper$ForDeclaredMethods
-dontwarn net.bytebuddy.asm.AsmVisitorWrapper
-dontwarn net.bytebuddy.description.ByteCodeElement$TypeDependant
-dontwarn net.bytebuddy.description.field.FieldList
-dontwarn net.bytebuddy.description.method.MethodDescription$ForLoadedMethod
-dontwarn net.bytebuddy.description.method.MethodDescription$InDefinedShape
-dontwarn net.bytebuddy.description.method.MethodDescription$SignatureToken
-dontwarn net.bytebuddy.description.method.MethodDescription
-dontwarn net.bytebuddy.description.method.MethodList
-dontwarn net.bytebuddy.description.method.ParameterDescription
-dontwarn net.bytebuddy.description.method.ParameterList
-dontwarn net.bytebuddy.description.modifier.ModifierContributor$ForField
-dontwarn net.bytebuddy.description.modifier.ModifierContributor$ForMethod
-dontwarn net.bytebuddy.description.modifier.Ownership
-dontwarn net.bytebuddy.description.modifier.SynchronizationState
-dontwarn net.bytebuddy.description.modifier.Visibility
-dontwarn net.bytebuddy.description.type.TypeDescription$ForLoadedType
-dontwarn net.bytebuddy.description.type.TypeDescription
-dontwarn net.bytebuddy.dynamic.ClassFileLocator$Simple
-dontwarn net.bytebuddy.dynamic.ClassFileLocator
-dontwarn net.bytebuddy.dynamic.DynamicType$Builder$FieldDefinition$Optional$Valuable
-dontwarn net.bytebuddy.dynamic.DynamicType$Builder$FieldDefinition$Optional
-dontwarn net.bytebuddy.dynamic.DynamicType$Builder$MethodDefinition$ExceptionDefinition
-dontwarn net.bytebuddy.dynamic.DynamicType$Builder$MethodDefinition$ImplementationDefinition$Optional
-dontwarn net.bytebuddy.dynamic.DynamicType$Builder$MethodDefinition$ImplementationDefinition
-dontwarn net.bytebuddy.dynamic.DynamicType$Builder$MethodDefinition$ParameterDefinition$Initial
-dontwarn net.bytebuddy.dynamic.DynamicType$Builder$MethodDefinition$ReceiverTypeDefinition
-dontwarn net.bytebuddy.dynamic.DynamicType$Builder$MethodDefinition
-dontwarn net.bytebuddy.dynamic.DynamicType$Builder
-dontwarn net.bytebuddy.dynamic.DynamicType$Loaded
-dontwarn net.bytebuddy.dynamic.DynamicType$Unloaded
-dontwarn net.bytebuddy.dynamic.Transformer$ForMethod
-dontwarn net.bytebuddy.dynamic.Transformer
-dontwarn net.bytebuddy.dynamic.loading.ClassInjector$UsingLookup
-dontwarn net.bytebuddy.dynamic.loading.ClassInjector$UsingReflection
-dontwarn net.bytebuddy.dynamic.loading.ClassLoadingStrategy$Configurable
-dontwarn net.bytebuddy.dynamic.loading.ClassLoadingStrategy$Default
-dontwarn net.bytebuddy.dynamic.loading.ClassLoadingStrategy$UsingLookup
-dontwarn net.bytebuddy.dynamic.loading.ClassLoadingStrategy
-dontwarn net.bytebuddy.dynamic.loading.MultipleParentClassLoader$Builder
-dontwarn net.bytebuddy.dynamic.loading.MultipleParentClassLoader
-dontwarn net.bytebuddy.dynamic.scaffold.MethodGraph$Compiler$Default
-dontwarn net.bytebuddy.dynamic.scaffold.MethodGraph$Compiler$ForDeclaredMethods
-dontwarn net.bytebuddy.dynamic.scaffold.MethodGraph$Compiler
-dontwarn net.bytebuddy.dynamic.scaffold.MethodGraph$Linked
-dontwarn net.bytebuddy.dynamic.scaffold.MethodGraph$Node$Sort
-dontwarn net.bytebuddy.dynamic.scaffold.MethodGraph$Node
-dontwarn net.bytebuddy.dynamic.scaffold.MethodGraph
-dontwarn net.bytebuddy.dynamic.scaffold.TypeValidation
-dontwarn net.bytebuddy.dynamic.scaffold.subclass.ConstructorStrategy$Default
-dontwarn net.bytebuddy.dynamic.scaffold.subclass.ConstructorStrategy
-dontwarn net.bytebuddy.implementation.FieldAccessor$OwnerTypeLocatable
-dontwarn net.bytebuddy.implementation.FieldAccessor
-dontwarn net.bytebuddy.implementation.Implementation$Composable
-dontwarn net.bytebuddy.implementation.Implementation$Context$Disabled$Factory
-dontwarn net.bytebuddy.implementation.Implementation$Context$Factory
-dontwarn net.bytebuddy.implementation.Implementation$Context
-dontwarn net.bytebuddy.implementation.Implementation
-dontwarn net.bytebuddy.implementation.MethodCall$WithoutSpecifiedTarget
-dontwarn net.bytebuddy.implementation.MethodCall
-dontwarn net.bytebuddy.implementation.MethodDelegation$WithCustomProperties
-dontwarn net.bytebuddy.implementation.MethodDelegation
-dontwarn net.bytebuddy.implementation.StubMethod
-dontwarn net.bytebuddy.implementation.attribute.MethodAttributeAppender$Factory
-dontwarn net.bytebuddy.implementation.attribute.MethodAttributeAppender$ForInstrumentedMethod
-dontwarn net.bytebuddy.implementation.attribute.MethodAttributeAppender$NoOp
-dontwarn net.bytebuddy.implementation.bind.annotation.AllArguments
-dontwarn net.bytebuddy.implementation.bind.annotation.Argument
-dontwarn net.bytebuddy.implementation.bind.annotation.BindingPriority
-dontwarn net.bytebuddy.implementation.bind.annotation.FieldValue
-dontwarn net.bytebuddy.implementation.bind.annotation.Origin
-dontwarn net.bytebuddy.implementation.bind.annotation.RuntimeType
-dontwarn net.bytebuddy.implementation.bind.annotation.StubValue
-dontwarn net.bytebuddy.implementation.bind.annotation.SuperCall
-dontwarn net.bytebuddy.implementation.bind.annotation.TargetMethodAnnotationDrivenBinder$ParameterBinder$ForFixedValue$OfConstant
-dontwarn net.bytebuddy.implementation.bind.annotation.TargetMethodAnnotationDrivenBinder$ParameterBinder
-dontwarn net.bytebuddy.implementation.bind.annotation.This
-dontwarn net.bytebuddy.implementation.bytecode.assign.Assigner$Typing
-dontwarn net.bytebuddy.jar.asm.ClassVisitor
-dontwarn net.bytebuddy.jar.asm.MethodVisitor
-dontwarn net.bytebuddy.matcher.ElementMatcher$Junction
-dontwarn net.bytebuddy.matcher.ElementMatcher
-dontwarn net.bytebuddy.matcher.ElementMatchers
-dontwarn net.bytebuddy.matcher.FilterableList
-dontwarn net.bytebuddy.pool.TypePool
-dontwarn net.bytebuddy.utility.OpenedClassReader
-dontwarn net.bytebuddy.utility.RandomString
-dontwarn org.mockito.internal.creation.bytebuddy.inject.MockMethodDispatcher














-keep class com.jiangdg.** { *; }















-keep class com.sun.jna.* { *; }
-keepclassmembers class * extends com.sun.jna.* { public *; }

-dontwarn java.awt.Component
-dontwarn java.awt.GraphicsEnvironment
-dontwarn java.awt.HeadlessException
-dontwarn java.awt.Window















