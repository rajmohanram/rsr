Certainly! Below is an example of an Architecture Decision Record (ADR) for the decision-making process of generating SBOM for a QCOW2 image built by Packer in an environment with restricted internet connectivity.

ADR: Generating SBOM for QCOW2 Images in a Restricted Connectivity Environment

Status

Proposed

Context

In the current environment, we are required to generate a Software Bill of Materials (SBOM) for QCOW2 images built by Packer. The environment has restricted internet connectivity, meaning tools must either operate offline or be able to download necessary resources in advance. Additionally, the SBOM needs to be generated in a format that ensures compatibility with the required compliance, security, and governance tools. We also need to incorporate vulnerability assessment into the process.

Problem
	•	We need a solution that can generate a reliable SBOM for the QCOW2 images built by Packer.
	•	The solution must support an offline mode due to limited internet connectivity.
	•	The SBOM format chosen must align with security and compliance requirements.
	•	We need a mechanism for vulnerability assessment based on the generated SBOM.

Tools Considered
	1.	Trivy
	•	Pros:
	•	Trivy is a well-known, reliable tool for SBOM generation and vulnerability scanning.
	•	It supports a variety of formats for SBOM, including SPDX and CycloneDX, which are widely recognized.
	•	Trivy supports both online and offline modes.
	•	Integrated vulnerability scanning.
	•	Cons:
	•	Requires initial internet connectivity to download vulnerability databases (which we can handle via manual downloading and offline setup).
	2.	Syft
	•	Pros:
	•	Fast and lightweight tool for SBOM generation.
	•	Supports various formats such as SPDX, CycloneDX, and more.
	•	Cons:
	•	Does not include vulnerability scanning. This would require integration with another tool, such as Grype or Trivy, to scan the SBOM for vulnerabilities.
	3.	Grype
	•	Pros:
	•	Excellent for vulnerability scanning.
	•	Can be used with Syft (to generate SBOM) for end-to-end vulnerability management.
	•	Cons:
	•	Does not directly generate an SBOM, so it would need to be used in conjunction with Syft.
	4.	CycloneDX CLI
	•	Pros:
	•	Focuses on CycloneDX format SBOM generation, a popular format in the DevSecOps space.
	•	Cons:
	•	Not a full-fledged SBOM generation tool. It’s more specialized and doesn’t offer other formats like SPDX.

Decision

After considering the available tools, the following decisions were made:
	1.	Tool Selection for SBOM Generation:
	•	Trivy will be used to generate the SBOM in SPDX format. Trivy provides a reliable, automated solution to generate SBOMs from QCOW2 images with good community support and documentation. It also has the added benefit of vulnerability scanning and offline support once the database is downloaded. The SPDX format is widely used in the industry, well-documented, and supports compliance requirements for open-source software, which makes it a suitable choice for our use case.
	2.	SBOM Format Chosen:
	•	SPDX format was selected for the SBOM. This format is widely adopted and recognized for its integration with open-source compliance tools and security audits. It also aligns with our industry’s standard for reporting dependencies and licenses, making it a better fit for our environment.
	3.	Vulnerability Assessment from SBOM:
	•	Trivy will be used for vulnerability scanning in conjunction with SBOM generation. Once the SBOM is created, it can be used for scanning vulnerabilities in dependencies, libraries, and software packages within the image.
	•	Offline Mode: Trivy will be set up to work offline by downloading the vulnerability database once and transferring it to the air-gapped system, allowing for scanning without requiring continuous internet access.

Justification for Tool and Format Choice
	1.	Trivy’s Offline Mode: Trivy’s ability to operate in offline mode by pre-downloading the vulnerability database aligns perfectly with the environment’s restricted internet connectivity. Once the vulnerability database is transferred to the air-gapped system, the tool can perform scans without internet access.
	2.	SPDX Format: The choice of SPDX format ensures that the SBOM can be easily integrated with other tools for compliance, reporting, and auditing. It is recognized across industries, particularly in open-source software compliance, and is more suited for Linux-based environments.
	3.	Integrated Vulnerability Scanning: Using Trivy for both SBOM generation and vulnerability assessment minimizes the overhead of managing multiple tools and integrates dependency scanning directly into the image build process.
	4.	Offline Capability: By downloading the databases and running the vulnerability scans offline, we ensure that the tool can be used in a disconnected environment, adhering to the organization’s security protocols for restricted networks.

Risks and Mitigations
	•	Risk: Manual downloading of the vulnerability database could result in outdated data.
	•	Mitigation: Ensure regular updates to the database whenever possible (via periodic internet access).
	•	Risk: Limited tool support for vulnerability assessment within the QCOW2 image.
	•	Mitigation: By using Trivy for both SBOM generation and vulnerability assessment, we ensure full compatibility between the SBOM and vulnerability reports.

Consequences
	•	We will use Trivy for SBOM generation and vulnerability scanning in the SPDX format.
	•	Trivy will operate in offline mode, which requires manual database downloads and regular updates whenever internet connectivity is available.
	•	We have a streamlined workflow for security auditing and compliance using SPDX, which will be easy to integrate into future pipeline automation.
	•	We will be able to track dependencies and vulnerabilities in our QCOW2 images, ensuring compliance with security standards.

Next Steps
	1.	Set up Trivy in offline mode and test vulnerability scanning with a sample QCOW2 image.
	2.	Automate the SBOM generation and vulnerability scanning in the Packer pipeline.
	3.	Implement a process for periodic database updates when internet connectivity is available.
	4.	Document and ensure that the SBOM files are stored securely for auditing purposes.

This ADR helps guide the decision to use Trivy for SBOM generation and vulnerability assessment while considering our environment’s limitations. The SPDX format was chosen for its compatibility with security and compliance tools.