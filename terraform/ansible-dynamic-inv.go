package main

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"os"

	tfjson "github.com/hashicorp/terraform-json"
	tfexec "github.com/hashicorp/terraform-exec/tfexec"
)

// FetchTerraformState pulls Terraform state and parses it
func FetchTerraformState(terraformPath, workspace, dir string) (*tfjson.State, error) {
	tf, err := tfexec.NewTerraform(dir, terraformPath)
	if err != nil {
		return nil, fmt.Errorf("failed to initialize Terraform: %v", err)
	}

	// Select workspace
	if err := tf.WorkspaceSelect(context.Background(), workspace); err != nil {
		return nil, fmt.Errorf("failed to select Terraform workspace: %v", err)
	}

	// Fetch the state
	stateJSON, err := tf.Show(context.Background())
	if err != nil {
		return nil, fmt.Errorf("failed to get Terraform state: %v", err)
	}

	// Parse state JSON
	var state tfjson.State
	if err := json.Unmarshal([]byte(stateJSON), &state); err != nil {
		return nil, fmt.Errorf("failed to parse Terraform state: %v", err)
	}

	return &state, nil
}

// GenerateAnsibleInventory converts Terraform state to an Ansible inventory
func GenerateAnsibleInventory(state *tfjson.State) (map[string]interface{}, error) {
	inventory := map[string]interface{}{
		"all": map[string]interface{}{
			"hosts": []string{},
			"_meta": map[string]interface{}{
				"hostvars": map[string]map[string]string{},
			},
		},
	}

	hostvars := inventory["all"].(map[string]interface{})["_meta"].(map[string]interface{})["hostvars"].(map[string]map[string]string)

	// Extract OpenStack instance information
	for _, resource := range state.Values.RootModule.Resources {
		if resource.Type == "openstack_compute_instance_v2" {
			name := resource.AttributeValues["name"].(string)
			ip := resource.AttributeValues["access_ip_v4"].(string)

			inventory["all"].(map[string]interface{})["hosts"] = append(inventory["all"].(map[string]interface{})["hosts"].([]string), name)
			hostvars[name] = map[string]string{
				"ansible_host": ip,
				"ansible_user": "ubuntu",
			}
		}
	}

	return inventory, nil
}

func main() {
	terraformPath := "/usr/local/bin/terraform"
	workspace := "production"
	workingDir := "/path/to/terraform/project"

	// Fetch Terraform state
	state, err := FetchTerraformState(terraformPath, workspace, workingDir)
	if err != nil {
		log.Fatalf("Error fetching Terraform state: %v", err)
	}

	// Generate Ansible inventory
	inventory, err := GenerateAnsibleInventory(state)
	if err != nil {
		log.Fatalf("Error generating Ansible inventory: %v", err)
	}

	// Convert inventory to JSON and print
	inventoryJSON, _ := json.MarshalIndent(inventory, "", "  ")
	fmt.Println(string(inventoryJSON))
}
