<?xml version="1.0"?>
<recipe>
    <#include "../common/recipe_manifest.xml.ftl" />

    <!-- app -->
    <instantiate from="app_package/app/App.java.ftl" to="${escapeXmlAttribute(srcOut)}/app/App.java" />
    <instantiate from="app_package/app/Constant.java.ftl" to="${escapeXmlAttribute(srcOut)}/app/Constant.java" />

    <!-- green dao -->
<#if hasGreenDao>
    <instantiate from="app_package/db/helper/AppDbHelper.java.ftl" to="${escapeXmlAttribute(srcOut)}/db/helper/AppDbHelper.java" />
    <instantiate from="app_package/db/helper/GreenUpdate.java.ftl" to="${escapeXmlAttribute(srcOut)}/db/helper/GreenUpdate.java" />
</#if>

    <!-- utils -->
    <instantiate from="app_package/utils/rxbus/RxBus.java.ftl" to="${escapeXmlAttribute(srcOut)}/utils/rxbus/RxBus.java" />
    <instantiate from="app_package/utils/BindingUtils.java.ftl" to="${escapeXmlAttribute(srcOut)}/utils/BindingUtils.java" />
    <instantiate from="app_package/utils/ImageUtils.java.ftl" to="${escapeXmlAttribute(srcOut)}/utils/ImageUtils.java" />
    <instantiate from="app_package/utils/Logger.java.ftl" to="${escapeXmlAttribute(srcOut)}/utils/Logger.java" />
    <instantiate from="app_package/utils/NotifyUtils.java.ftl"  to="${escapeXmlAttribute(srcOut)}/utils/NotifyUtils.java" />
    <instantiate from="app_package/utils/Tip.java.ftl"  to="${escapeXmlAttribute(srcOut)}/utils/Tip.java" />
    <instantiate from="app_package/utils/UpdateUtils.java.ftl"  to="${escapeXmlAttribute(srcOut)}/utils/UpdateUtils.java" />

    <!-- view -->
    <instantiate from="app_package/layout/layout.xml.ftl" to="${escapeXmlAttribute(resOut)}/layout/${layoutName}.xml" />

    <instantiate from="app_package/view/Activity.java.ftl" to="${escapeXmlAttribute(srcOut)}/view/view/${activityClass}.java" />

    <instantiate from="app_package/view/IBaseContract.java.ftl" to="${escapeXmlAttribute(srcOut)}/view/contract/IBaseContract.java"/>

    <instantiate from="app_package/view/IContract.java.ftl" to="${escapeXmlAttribute(srcOut)}/view/contract/${contractClass}.java" />

    <instantiate from="app_package/view/Presenter.java.ftl" to="${escapeXmlAttribute(srcOut)}/view/presenter/${presenterClass}.java" />

    <open file="${escapeXmlAttribute(srcOut)}/view/view/${activityClass}.java" />
    <open file="${escapeXmlAttribute(resOut)}/layout/${layoutName}.xml" />

</recipe>
