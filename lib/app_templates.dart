import 'package:xml/xml.dart';

import 'app_constants.dart';


String templateProjectStructureXML() {
  final builder = XmlBuilder();

  builder.processing('xml', 'version="1.0"');
  builder.element('project', nest: () {
    builder.element('fileVersion', nest: projectVersion);
    builder.element('directoryStructure', nest: () {
      builder.element('entry', attributes: {'type': 'file'}, nest: 'Overview.tale');
      builder.element('entry',
          attributes: {'type': 'folder', 'extension': '.tale_chap'}, nest: 'Chapters');
      builder.element('entry',
          attributes: {'type': 'folder', 'extension': '.tale_char'}, nest: 'Characters');
      builder.element('entry',
          attributes: {'type': 'folder', 'extension': '.tale_local'}, nest: 'Locations');
      builder.element('entry',
          attributes: {'type': 'folder', 'extension': '.tale_res'}, nest: 'Research');
      builder.element('entry',
          attributes: {'type': 'folder', 'extension': ''}, nest: 'Recycle Bin');
    });
  });

  return builder.buildDocument().toXmlString(pretty: true);
}

String templateSubFolderStructureXML(String directoryExtension) {
  final builder = XmlBuilder();

  builder.processing('xml', 'version="1.0"');
  builder.element('projectFolder', nest: () {
    builder.element('fileVersion', nest: projectVersion);
    builder.element('directoryStructure', nest: () {});
    builder.element('directoryExtension', nest: directoryExtension);
    builder.element('startExpanded', nest: false);
  });

  return builder.buildDocument().toXmlString(pretty: true);
}

String templateOverviewXML(String projectName, String projectDescription,
    String projectCopyrightHolder, String projectCreationDate) {
  final builder = XmlBuilder();

  builder.processing('xml', 'version="1.0"');
  builder.element('projectFile', nest: () {
    builder.element('fileVersion', nest: projectVersion);
    builder.element('projectName', nest: projectName);
    builder.element('projectDescription', nest: projectDescription);
    builder.element('projectCopyrightHolder', nest: projectCopyrightHolder);
    builder.element('projectCreationDate', nest: projectCreationDate);
  });

  return builder.buildDocument().toXmlString(pretty: true);
}
