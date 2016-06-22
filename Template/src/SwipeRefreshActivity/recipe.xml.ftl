<?xml version="1.0"?>
<recipe>
    <#include "../common/recipe_manifest.xml.ftl" />

    <instantiate from="root/src/app_package/layout/layout.xml.ftl"
                         to="${escapeXmlAttribute(resOut)}/layout/${layoutName}.xml" />

    <instantiate from="root/src/app_package/classes/Activity.java.ftl"
                   to="${escapeXmlAttribute(srcOut)}/view/${activityClass}.java" />

    <instantiate from="root/src/app_package/classes/IContract.java.ftl"
                       to="${escapeXmlAttribute(srcOut)}/contract/${contractClass}.java" />

    <instantiate from="root/src/app_package/classes/Presenter.java.ftl"
                       to="${escapeXmlAttribute(srcOut)}/presenter/${presenterClass}.java" />

    <open file="${escapeXmlAttribute(srcOut)}/view/${activityClass}.java" />
    <open file="${escapeXmlAttribute(resOut)}/layout/${layoutName}.xml" />
</recipe>
