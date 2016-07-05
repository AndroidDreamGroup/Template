<#if !(perModuleRepositories??) || perModuleRepositories>
buildscript {
    repositories {
        jcenter()
<#if mavenUrl != "mavenCentral">
        maven {
            url '${mavenUrl}'
        }
</#if>
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:${gradlePluginVersion}'
    }
}
</#if>
<#if isLibraryProject?? && isLibraryProject>
apply plugin: 'com.android.library'
<#else>
apply plugin: 'com.android.application'
apply plugin: 'me.tatarka.retrolambda'
</#if>
<#if !(perModuleRepositories??) || perModuleRepositories>

repositories {
        jcenter()
<#if mavenUrl != "mavenCentral">
        maven {
            url '${mavenUrl}'
        }
</#if>
}
</#if>

android {
    compileSdkVersion <#if buildApiString?matches("^\\d+$")>${buildApiString}<#else>'${buildApiString}'</#if>
    buildToolsVersion "${buildToolsVersion}"

    dataBinding {
        enabled true
    }

    defaultConfig {
    <#if isLibraryProject?? && isLibraryProject>
    <#else>
    applicationId "${packageName}"
    </#if>
        minSdkVersion <#if minApi?matches("^\\d+$")>${minApi}<#else>'${minApi}'</#if>
        targetSdkVersion <#if targetApiString?matches("^\\d+$")>${targetApiString}<#else>'${targetApiString}'</#if>
        versionCode 1
        versionName "1.0"
    }

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }

    buildTypes {

        debug {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }

        release {
            minifyEnabled true
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }

    productFlavors {
        dev {
            buildConfigField "String", "API_BASE_URL", '"${apiUrlDebug}"'
        }
        product {
            buildConfigField "String", "API_BASE_URL", '"${apiUrlRelease}"'
        }
    }

    packagingOptions {
        exclude 'META-INF/DEPENDENCIES'
        exclude 'META-INF/NOTICE'
        exclude 'META-INF/LICENSE'
    }

    defaultConfig {
        multiDexEnabled true
    }

}

repositories {
    flatDir {
        dirs 'libs'
    }
}

dependencies {
    <#if dependencyList?? >
    <#list dependencyList as dependency>
    compile '${dependency}'
    </#list>
    </#if>
    compile fileTree(dir: 'libs', include: ['*.jar'])
<#if WearprojectName?has_content && NumberOfEnabledFormFactors?has_content && NumberOfEnabledFormFactors gt 1 && Wearincluded>
    wearApp project(':${WearprojectName}')
    compile 'com.google.android.gms:play-services:+'
</#if>
<#if unitTestsSupported>
    testCompile 'junit:junit:${junitVersion}'
</#if>
}
