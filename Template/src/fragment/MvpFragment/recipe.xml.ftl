<?xml version="1.0"?>
<recipe>

    <instantiate from="app_package/layout/layout.xml.ftl"
                         to="${escapeXmlAttribute(resOut)}/layout/${layoutName}.xml" />

    <instantiate from="app_package/classes/MvpFragment.java.ftl"
                   to="${escapeXmlAttribute(srcOut)}/view/${fragmentClass}.java" />

    <instantiate from="app_package/classes/IContract.java.ftl"
                       to="${escapeXmlAttribute(srcOut)}/contract/${contractClass}.java" />

    <instantiate from="app_package/classes/Presenter.java.ftl"
                       to="${escapeXmlAttribute(srcOut)}/presenter/${presenterClass}.java" />

    <open file="${escapeXmlAttribute(srcOut)}/view/${fragmentClass}.java" />
    <open file="${escapeXmlAttribute(resOut)}/layout/${layoutName}.xml" />
</recipe>
