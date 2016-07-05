<?xml version="1.0"?>
<recipe>

    <dependency mavenUrl="com.android.support:appcompat-v7:${buildApi}.+"/>
    <dependency mavenUrl="com.android.support:cardview-v7:${buildApi}.+"/>
    <dependency mavenUrl="io.reactivex:rxjava:1.1.2"/>
    <dependency mavenUrl="io.reactivex:rxandroid:1.1.0"/>
    <dependency mavenUrl="com.squareup.retrofit2:retrofit:2.0.0"/>
    <dependency mavenUrl="com.squareup.retrofit2:converter-gson:2.0.0"/>
    <dependency mavenUrl="com.squareup.retrofit2:adapter-rxjava:2.0.0"/>
    <dependency mavenUrl="com.squareup.okhttp3:logging-interceptor:3.2.0"/>
    <dependency mavenUrl="com.jakewharton:butterknife:7.0.1"/>
    <dependency mavenUrl="com.facebook.fresco:fresco:0.9.0"/>
    <dependency mavenUrl="com.jakewharton.rxbinding:rxbinding:0.4.0"/>
    <dependency mavenUrl="com.jakewharton.rxbinding:rxbinding-appcompat-v7:0.4.0"/>
    <dependency mavenUrl="com.jakewharton.rxbinding:rxbinding-support-v4:0.4.0"/>
    <dependency mavenUrl="com.trello:rxlifecycle-components:0.6.1"/>

<#if !createActivity>
    <mkdir at="${escapeXmlAttribute(srcOut)}" />
</#if>

    <mkdir at="${escapeXmlAttribute(projectOut)}/libs" />

    <merge from="root/settings.gradle.ftl"
             to="${escapeXmlAttribute(topOut)}/settings.gradle" />
    <instantiate from="root/build.gradle.ftl"
                   to="${escapeXmlAttribute(projectOut)}/build.gradle" />
    <instantiate from="root/AndroidManifest.xml.ftl"
                   to="${escapeXmlAttribute(manifestOut)}/AndroidManifest.xml" />

<mkdir at="${escapeXmlAttribute(resOut)}/drawable" />
<#if copyIcons && !isLibraryProject>
    <copy from="root/res/mipmap-hdpi"
            to="${escapeXmlAttribute(resOut)}/mipmap-hdpi" />
    <copy from="root/res/mipmap-mdpi"
            to="${escapeXmlAttribute(resOut)}/mipmap-mdpi" />
    <copy from="root/res/mipmap-xhdpi"
            to="${escapeXmlAttribute(resOut)}/mipmap-xhdpi" />
    <copy from="root/res/mipmap-xxhdpi"
            to="${escapeXmlAttribute(resOut)}/mipmap-xxhdpi" />
    <copy from="root/res/mipmap-xxxhdpi"
            to="${escapeXmlAttribute(resOut)}/mipmap-xxxhdpi" />
</#if>
<#if makeIgnore>
    <copy from="root/module_ignore"
            to="${escapeXmlAttribute(projectOut)}/.gitignore" />
</#if>
<#if enableProGuard>
    <instantiate from="root/proguard-rules.txt.ftl"
                   to="${escapeXmlAttribute(projectOut)}/proguard-rules.pro" />
</#if>
<#if !(isLibraryProject??) || !isLibraryProject>
    <instantiate from="root/res/values/styles.xml.ftl"
                   to="${escapeXmlAttribute(resOut)}/values/styles.xml" />
<#if buildApi gte 22>
    <copy from="root/res/values/colors.xml"
          to="${escapeXmlAttribute(resOut)}/values/colors.xml" />
</#if>
</#if>

    <instantiate from="root/res/values/strings.xml.ftl"
                   to="${escapeXmlAttribute(resOut)}/values/strings.xml" />

    <instantiate from="root/test/app_package/ApplicationTest.java.ftl"
                   to="${escapeXmlAttribute(testOut)}/ApplicationTest.java" />

<#if unitTestsSupported>
    <instantiate from="root/test/app_package/ExampleUnitTest.java.ftl"
                   to="${escapeXmlAttribute(unitTestOut)}/ExampleUnitTest.java" />
</#if>

</recipe>
