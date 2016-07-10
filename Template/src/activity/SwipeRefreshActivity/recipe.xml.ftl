<?xml version="1.0"?>
<recipe>
    <#include "../common/recipe_manifest.xml.ftl" />

<#if generateLayout>
    <instantiate from="app_package/layout/layout.xml.ftl"
                         to="${escapeXmlAttribute(resOut)}/layout/${layoutName}.xml" />
</#if>

<#if generateItemLayout>
    <instantiate from="app_package/layout/listitem_layout.xml.ftl"
                         to="${escapeXmlAttribute(resOut)}/layout/${listItemLayout}.xml" />
</#if>

    <instantiate from="app_package/classes/Activity.java.ftl"
                   to="${escapeXmlAttribute(srcOut)}/view/${activityClass}.java" />

    <instantiate from="app_package/classes/Adapter.java.ftl"
                       to="${escapeXmlAttribute(srcOut)}/adapter/${adapterClass}.java" />

    <instantiate from="app_package/classes/Bean.java.ftl"
                       to="${escapeXmlAttribute(srcOut)}/entity/${beanClass}.java" />

    <instantiate from="app_package/classes/IContract.java.ftl"
                       to="${escapeXmlAttribute(srcOut)}/contract/${contractClass}.java" />

    <instantiate from="app_package/classes/Presenter.java.ftl"
                       to="${escapeXmlAttribute(srcOut)}/presenter/${presenterClass}.java" />

    <open file="${escapeXmlAttribute(srcOut)}/view/${activityClass}.java" />
    <open file="${escapeXmlAttribute(resOut)}/layout/${layoutName}.xml" />
</recipe>
