# Security Assessment Report Template

This template provides a structure for documenting security assessments and penetration testing results.

## Directory Structure

```
reports/
├── templates/      # Report templates
├── findings/       # Individual findings
├── screenshots/    # Evidence screenshots
└── final/          # Final report output
```

## Report Structure

A typical security assessment report should include:

1. **Executive Summary**
2. **Scope and Methodology**
3. **Findings**
4. **Recommendations**
5. **Appendices**

## Markdown Report Template

```markdown
# Security Assessment Report

**Client:** [Client Name]
**Assessment Period:** [Start Date] - [End Date]
**Assessed By:** [Your Name/Team]
**Report Date:** [Report Date]

---

## Executive Summary

[High-level overview of the assessment, key findings, and overall risk level]

### Key Statistics
- Total Findings: X
- Critical: X
- High: X
- Medium: X
- Low: X
- Informational: X

### Risk Rating
**Overall Risk Level:** [Critical/High/Medium/Low]

[Brief explanation of the overall security posture]

---

## Scope and Methodology

### Assessment Scope

**In Scope:**
- [Target systems/applications]
- [IP ranges]
- [Domains]

**Out of Scope:**
- [Excluded systems]
- [Limitations]

### Methodology

The assessment followed industry-standard methodologies:
- OWASP Testing Guide
- NIST SP 800-115
- PTES (Penetration Testing Execution Standard)

**Testing Phases:**
1. Reconnaissance
2. Vulnerability Assessment
3. Exploitation
4. Post-Exploitation
5. Reporting

---

## Findings

### Finding 1: [Vulnerability Title]

**Severity:** [Critical/High/Medium/Low/Info]
**CVSS Score:** [Score] ([Vector String])
**Status:** Open

#### Description
[Detailed description of the vulnerability]

#### Impact
[What could an attacker do with this vulnerability?]

#### Affected Systems
- System 1: [IP/hostname]
- System 2: [IP/hostname]

#### Evidence
```
[Command output, code snippets, or logs]
```

![Screenshot](../screenshots/finding-1-screenshot.png)

#### Proof of Concept
```bash
# Steps to reproduce
nmap -sV -p 445 target.example.com
```

#### Remediation
**Short-term:**
- [Immediate actions to reduce risk]

**Long-term:**
- [Permanent fixes]

#### References
- [CVE-XXXX-XXXX]
- [URL to advisory]

---

### Finding 2: [Another Vulnerability]
[Repeat structure]

---

## Recommendations

### Critical Priority
1. [Action item]
2. [Action item]

### High Priority
1. [Action item]
2. [Action item]

### Medium Priority
1. [Action item]

### General Recommendations
- Implement security awareness training
- Establish patch management process
- Deploy security monitoring
- Conduct regular security assessments

---

## Conclusion

[Summary of findings and overall recommendations]

---

## Appendices

### Appendix A: Testing Tools
- Nmap v7.94
- Metasploit Framework v6.x
- Burp Suite Professional
- [Other tools used]

### Appendix B: Credentials Found
[Securely document any credentials found - encrypt this section]

### Appendix C: Full Scan Results
[Attach raw scan outputs]

---

**Report Classification:** CONFIDENTIAL
**Distribution:** [Authorized recipients only]
```

## Finding Severity Matrix

| Severity | CVSS Score | Description |
|----------|------------|-------------|
| Critical | 9.0-10.0 | Immediate exploitation possible, severe impact |
| High | 7.0-8.9 | Easy exploitation, significant impact |
| Medium | 4.0-6.9 | Exploitation requires specific conditions |
| Low | 0.1-3.9 | Limited impact or difficult to exploit |
| Info | 0.0 | No direct security impact |

## Report Generation

### Using Markdown to PDF
```bash
# Install pandoc if needed
sudo apt-get install pandoc texlive-latex-base

# Convert to PDF
pandoc report.md -o final/report.pdf --toc
```

### Using Python for Report Automation
```python
#!/usr/bin/env python3
import markdown
from datetime import datetime

def generate_report(findings):
    report = f"""
# Security Assessment Report
Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}

## Findings Summary
Total Findings: {len(findings)}
"""

    for finding in findings:
        report += f"\n### {finding['title']}\n"
        report += f"Severity: {finding['severity']}\n"
        report += f"{finding['description']}\n\n"

    return report

# Use this template to automate report generation
```

## Best Practices

- Use clear, non-technical language in the Executive Summary
- Include evidence for all findings (screenshots, logs)
- Provide actionable remediation steps
- Prioritize findings by actual risk, not just CVSS score
- Encrypt reports containing sensitive information
- Follow disclosure timelines agreed with the client
