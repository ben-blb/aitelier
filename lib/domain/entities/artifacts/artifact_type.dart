enum ArtifactType {
  text,          // Generic LLM output
  code,          // Source code
  markdown,      // Docs, specs
  decision,      // Architectural or product decision
  plan,          // Execution plans
  summary,       // Condensed knowledge
  dataset,       // Structured data
  unknown        // Fallback
}
