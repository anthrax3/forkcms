{include:{$BACKEND_CORE_PATH}/Layout/Templates/Head.tpl}
{include:{$BACKEND_CORE_PATH}/Layout/Templates/StructureStartModule.tpl}
<div class="row fork-module-heading">
	<div class="col-md-12">
		<h2>{$msgEditProfile|sprintf:{$profile.email}|ucfirst}</h2>
	</div>
</div>
{form:edit}
	<div class="row fork-module-content">
		<div class="col-md-12">
			<div role="tabpanel">
				<ul class="nav nav-tabs" role="tablist">
					<li role="presentation" class="active">
						<a href="#tabGeneral" aria-controls="general" role="tab" data-toggle="tab">{$lblGeneral|ucfirst}</a>
					</li>
					<li role="presentation">
						<a href="#tabGroups" aria-controls="groups" role="tab" data-toggle="tab">{$lblGroups|ucfirst}</a>
					</li>
				</ul>
				<div class="tab-content">
					<div role="tabpanel" class="tab-pane active" id="tabGeneral">
						<div class="row">
							<div class="col-md-12">
								<h3>{$lblGeneral|ucfirst}</h3>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h3 class="panel-title">{$lblProfile|ucfirst}</h3>
									</div>
									<div class="panel-body">
										<div class="form-group">
											<label for="email">
												{$lblEmail|ucfirst}
												<abbr class="glyphicon glyphicon-info-sign" title="{$lblRequiredField|ucfirst}"></abbr>
											</label>
											{$txtEmail} {$txtEmailError}
										</div>
										<div class="form-group">
											<label for="displayName">
												{$lblDisplayName|ucfirst}
												<abbr class="glyphicon glyphicon-info-sign" title="{$lblRequiredField|ucfirst}"></abbr>
											</label>
											{$txtDisplayName} {$txtDisplayNameError}
										</div>
										<div class="form-group">
											<label for="password">
												{$lblPassword|ucfirst}
												<abbr class="glyphicon glyphicon-info-sign" title="{$lblRequiredField|ucfirst}"></abbr>
											</label>
											{$txtPassword} {$txtPasswordError}
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h3 class="panel-title">{$lblSettings|ucfirst}</h3>
									</div>
									<div class="panel-body">
										<div class="form-group">
											<label for="firstName">{$lblFirstName|ucfirst}</label>
											{$txtFirstName} {$txtFirstNameError}
										</div>
										<div class="form-group">
											<label for="lastName">{$lblLastName|ucfirst}</label>
											{$txtLastName} {$txtLastNameError}
										</div>
										<div class="form-group">
											<label for="gender">{$lblGender|ucfirst}</label>
											{$ddmGender} {$ddmGenderError}
										</div>
										<div class="form-group">
											<label for="day">{$lblBirthDate|ucfirst}</label>
											<div class="form-inline">
												<div class="form-group">{$ddmDay}</div>
												<div class="form-group">{$ddmMonth}</div>
												<div class="form-group">{$ddmYear}</div>
												{$ddmYearError}
											</div>
										</div>
										<div class="form-group">
											<label for="city">{$lblCity|ucfirst}</label>
											{$txtCity} {$txtCityError}
										</div>
										<div class="form-group">
											<label for="country">{$lblCountry|ucfirst}</label>
											{$ddmCountry} {$ddmCountryError}
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div role="tabpanel" class="tab-pane" id="tabGroups">
						<div class="row">
							<div class="col-md-12">
								<h3>{$lblGroups|ucfirst}</h3>
								{option:showProfilesAddProfileGroup}
								<div class="btn-toolbar pull-right">
									<div class="btn-group" role="group">
										<a href="{$var|geturl:'add_profile_group'}&amp;id={$profile.id}" class="btn btn-primary" title="{$lblAddGroup|ucfirst}">
											<span class="glyphicon glyphicon-plus-sign"></span>&nbsp;
											{$lblAddGroup|ucfirst}
										</a>
									</div>
								</div>
								{/option:showProfilesAddProfileGroup}
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								{option:dgGroups}
								{$dgGroups}
								{/option:dgGroups}
								{option:!dgGroups}
								<p>{$msgNoGroups}</p>
								{/option:!dgGroups}
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row fork-page-actions">
		<div class="col-md-12">
			<div class="btn-toolbar">
				<div class="btn-group pull-left" role="group">
					{option:showProfilesDelete}
					{option:deleted}
					<button type="button" class="btn btn-success" data-toggle="modal" data-target="#confirmUndelete">
						<span class="glyphicon glyphicon-ok"></span>
						{$lblUndelete|ucfirst}
					</button>
					{/option:deleted}
					{option:!deleted}
					<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#confirmDelete">
						<span class="glyphicon glyphicon-trash"></span>
						{$lblDelete|ucfirst}
					</button>
					{/option:!deleted}
					{/option:showProfilesDelete}
					{option:showProfilesBlock}
					{option:blocked}
					<button type="button" class="btn btn-success" data-toggle="modal" data-target="#confirmUnblock">
						<span class="glyphicon glyphicon-ok"></span>
						{$lblUnblock|ucfirst}
					</button>
					{/option:blocked}
					{option:!blocked}
					<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#confirmBlock">
						<span class="glyphicon glyphicon-ban-circle"></span>
						{$lblBlock|ucfirst}
					</button>
					{/option:!blocked}
					{/option:showProfilesBlock}
				</div>
				<div class="btn-group pull-right" role="group">
					<button id="saveButton" type="submit" name="edit" class="btn btn-primary">
						<span class="glyphicon glyphicon-pencil"></span>&nbsp;{$lblSave|ucfirst}
					</button>
				</div>
			</div>
			{option:showProfilesDelete}
			<div class="modal fade" id="{option:deleted}confirmUndelete{/option:deleted}{option:!deleted}confirmDelete{/option:!deleted}" tabindex="-1" role="dialog" aria-labelledby="{option:deleted}{$lblUndelete|ucfirst}{/option:deleted}{option:!deleted}{$lblDelete|ucfirst}{/option:!deleted}" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							{option:deleted}
							<span class="modal-title h4">{$lblUndelete|ucfirst}</span>
							{/option:deleted}
							{option:!deleted}
							<span class="modal-title h4">{$lblDelete|ucfirst}</span>
							{/option:!deleted}
						</div>
						<div class="modal-body">
							{option:deleted}
							<p>{$msgConfirmUndelete|sprintf:{$profile.email}}</p>
							{/option:deleted}
							{option:!deleted}
							<p>{$msgConfirmDelete|sprintf:{$profile.email}}</p>
							{/option:!deleted}
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">{$lblCancel|ucfirst}</button>
							{option:deleted}
							<a href="{$var|geturl:'delete'}&amp;id={$profile.id}" class="btn btn-primary">
								{$lblOK|ucfirst}
							</a>
							{/option:deleted}
							{option:!deleted}
							<a href="{$var|geturl:'delete'}&amp;id={$profile.id}" class="btn btn-primary">
								{$lblOK|ucfirst}
							</a>
							{/option:!deleted}
						</div>
					</div>
				</div>
			</div>
			{/option:showProfilesDelete}
			{option:showProfilesBlock}
			<div class="modal fade" id="{option:blocked}confirmUnblock{/option:blocked}{option:!blocked}confirmBlock{/option:!blocked}" tabindex="-1" role="dialog" aria-labelledby="{option:blocked}{$lblUnblock|ucfirst}{/option:blocked}{option:!blocked}{$lblBlock|ucfirst}{/option:!blocked}" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							{option:blocked}
							<span class="modal-title h4">{$lblUnblock|ucfirst}</span>
							{/option:blocked}
							{option:!blocked}
							<span class="modal-title h4">{$lblBlock|ucfirst}</span>
							{/option:!blocked}
						</div>
						<div class="modal-body">
							{option:blocked}
							<p>{$msgConfirmUnblock|sprintf:{$profile.email}}</p>
							{/option:blocked}
							{option:!blocked}
							<p>{$msgConfirmBlock|sprintf:{$profile.email}}</p>
							{/option:!blocked}
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">{$lblCancel|ucfirst}</button>
							{option:blocked}
							<a href="{$var|geturl:'block'}&amp;id={$profile.id}" class="btn btn-primary">
								{$lblOK|ucfirst}
							</a>
							{/option:blocked}
							{option:!blocked}
							<a href="{$var|geturl:'block'}&amp;id={$profile.id}" class="btn btn-primary">
								{$lblOK|ucfirst}
							</a>
							{/option:!blocked}
						</div>
					</div>
				</div>
			</div>
			{/option:showProfilesBlock}
		</div>
	</div>
{/form:edit}

{include:{$BACKEND_CORE_PATH}/Layout/Templates/StructureEndModule.tpl}
{include:{$BACKEND_CORE_PATH}/Layout/Templates/Footer.tpl}
